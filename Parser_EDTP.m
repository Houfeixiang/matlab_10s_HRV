function [Dt] = Parser_EDTP(filename,gain1,Vref,fs)
%Takes file path in and outputs array of data
%optional extra filename saves to .mat file with broken out variable names
%ADC data is output in unsigned format, eg. 0 to 2^b-1
    if exist(filename, 'file')
        fileID = fopen(filename);
        fseek(fileID,0,1); % Move to End of file 
        numBytes = ftell(fileID); % Location of the end of the file 
        Inf1 = numBytes/60; % Number of packects
        fseek(fileID,0,-1); % Move to beginning of the file 
        packet_count = 0;
        hdr = fread(fileID,[1,Inf],'int16',58,'b')'; %read first two bytes of every 60bytes, each hdr is '55FF'
        good_hdr = hdr(hdr == hex2dec('55FF')); %packets that have the correct header 
        if ~any(good_hdr)
            disp(['Bad header(s) found: ' num2str(hdr(find(good_hdr == 0,1,'first'))) ' file: ' filename]);
        end
        
        % Packet Type
        fseek(fileID,2,'bof'); %go back to beginning where first packet ID is
        id = fread(fileID,[1,Inf],'int8',59,'b')'; %read first bytes of every 60bytes; Data Packets have id=3 for miniBERPS
        %good_id = id(id == hex2dec('01')); %packets that have the correct packet ID
        good_id = (id == hex2dec('03'));
        
        % Packet Index, it circles from <0000> to <FFFF> 
        fseek(fileID,3,'bof'); %go back to beginning where first packet count is
        n = fread(fileID,[1,Inf],'uint16',58,'b')'; 
       % n = n(good_id) % May use this if all packet are Data Packet
        
        % Get GPIO bits - 2 Bytes, AFE bits are specified by 1 bit 
        fseek(fileID,5,'bof'); %go back to beginning where first gpio byte is
        gpio = fread(fileID,[16,Inf],'16*ubit1',58*8,'b')'; % This uses 16 unsigned bit as each bit represent a gpio state
        %gpio = gpio(good_id)
        
        % Get AFE Gain - 2 bytes, AFE bits are specified by 2 bits 
        fseek(fileID,7,'bof'); %go back to beginning where first gain setting byte is
        gain = fread(fileID,[8,Inf],'8*ubit2',58*8,'b')';
        %gain = gain(good_id)
        
        % GET TBD byte - 1 Byte
        fseek(fileID,9,'bof'); %go back to beginning where first tbd byte is
        tbd = fread(fileID,[1,Inf],'ubit8',59*8,'b')';
        %tbd = tbd(good_id)
        
        % Get data from 8-Channel - Each channel is 3-Bytes - 24 bits
        fseek(fileID,10,'bof'); %go back to beginning where first adc1 byte is
        adc1 = fread(fileID,[8,Inf],'8*ubit24',36*8,'b')';  % 36 specifies number of bytes to skip ( 60 -8*3byte = 36)
        %adc1 = adc1(good_id)
        
%         % Get Sync Channel - Its 1-Byte
%         fseek(fileID,34,'bof'); %go back to beginning where first adc2 byte is
%         syncall = fread(fileID,[8,Inf],'8*ubit1',59*8,'b')';
%         
%         % Code for getting motion data is missing
%         
%         % Get MiniBERPS GPIO 
%         fseek(fileID,56,'bof'); %go back to beginning where first adc2 byte is
%         gpioMini = fread(fileID,[16,Inf],'16*ubit1',58*8,'b')';
%         % Get Check SUM 
%         fseek(fileID,58,'bof'); %go back to beginning where first checksum byte is
%         checksum = fread(fileID,[1,Inf],'uint16',58,'b')';
%         %checksum = checksum(good_id)
        
        % Find the device ID 
        %%%% use this when using userstudy data 
%         devTloc = find(id ==11);
%         fseek(fileID, (devTloc(1)-1)*60+5, 'bof');
%         devID = char(fread(fileID,[1,16],'char'));
        %%%%%%%
        devID = char('temp');
        fclose(fileID);
        
        %hdr = hdr(good_id)
        %outdata = [id n gpio gain tbd adc1 adc2 checksum];
        
        if nargin > 1 %save to mat file

            % Data from ADC 
            VoltPerLsb = (Vref/2^23)/gain1;
            for i=1:1:8
                Dt.adc{i} = adc1(:,i);
                Dt.adc{i} = Dt.adc{i}(good_id);  
                [Dt.ev{i}] = (Dt.adc{i}).*VoltPerLsb;
            end
            Dt.tx = 0:1:(length(Dt.adc{1})-1);
            Dt.tx = Dt.tx ./ fs;

        end
    else
        disp(['Can''t open: ' filename]);
    end
end

