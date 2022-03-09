try
    fclose(fid);
end

close all
clear all
clc

fid = serial('/dev/ttyUSB0','BaudRate',921600);
fopen(fid);

fs = 10000;
N = 500;
y = zeros(1,N/2);
data = zeros(1,N);
    
cdata = 0;
    
while(1)

    flushinput(fid);
    fwrite(fid,cdata,'uint8');
    data = fread(fid,N,'uint8');
   
    
    for n=1:N/2
        y(n) = double(data(2*n-1))*256+ double(data(2*n));
    end

    
    M = round(N/2);
    subplot(2,1,1);
    y = 3.3*y/4095;
    t = linspace(0,M*1/fs,M)*1000;
    plot(t,y);
    xlabel('ms');
    ylabel('V');
    axis([0 t(end) 0 4]);
    
    y(1) = 0;
    subplot(2,1,2); 
    Y = abs(fft(y))/M;
    M = round(N/4);
    Y = Y(1:M);
    f = linspace(0,fs/2,M)/1000;
    plot(f,Y,'r'); 
    ylabel('V/Hz'); 
    xlabel('kHz');
    
    axis([0 f(end) 0 1]);
    pause(0.01);
end




fclose(fid);