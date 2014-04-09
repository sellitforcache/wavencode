function [varargout]=helix(varargin)

if nargin == 1 | nargin == 2 | nargin == 3 | nargin == 4
    error('enter mean frequency, frequnecy amplitude, mod frequency, sample length, and file name');
end

if nargin == 5
   mean=varargin{1};
   amp=varargin{2};
   hfreq=varargin{3};
   time=varargin{4};
   name=varargin{5};
end

hightemp=zeros(time*44100,1);

for k=1:time*44100
    
    currentfreq=amp*sin(k*pi*hfreq/22050);
    
    hightemp(k)=1*sin(k*pi*(mean)/22050);
     
end

wavwrite(hightemp,44100,'testing.wav');
    
if nargout == 1
varargout{1}=hightemp;
end