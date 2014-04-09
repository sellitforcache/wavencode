function [varargout]=wavencode(varargin);

if nargin == 1 | nargin  == 2
    
end

if nargin == 3
   in=varargin{1};
   time=varargin{2};
   name=varargin{3};
   maxfreq=22050;
end

if nargin == 4
   in=varargin{1};
   time=varargin{2};
   name=varargin{3};
   maxfreq=varargin{4};
end

warning off all

in=double(in);
[rows,columns]=size(in);        %get # of rows and columns in image
binwidth=maxfreq/rows;            %width of frequency bin in Hz
binlength=time/columns;         %length of bin in s
in=(in-min(min(in)))/max(max(in-min(min(in))));                  %normalize graphic

out=zeros(time*44100,1);
temp=zeros(binlength*44100,1);

for k=1:columns                     %number of columns to go across
    for r=1:rows                    %number of rows to go down
        if r==1
            currentfreq=maxfreq-binwidth/2;
        else
            currentfreq=currentfreq-binwidth;
        end
        for i=1:1:fix(44100*binlength)         % # of sample points
    
            temp(i)=in(r,k)*sin(pi*i*currentfreq/maxfreq);    

        end
        strdex=(k-1)*binlength*44100+1;
        enddex=k*binlength*44100;
        out(strdex:enddex)=temp+out(strdex:enddex);
        out(strdex:enddex)=temp+out(strdex:enddex);
    end
    out(strdex:enddex)=out(strdex:enddex)/max(out(strdex:enddex));
end

out=out/max(out);

wavwrite(out,44100,name);

if nargout==1
    
    varargout{1}=out;
    
end

warning on all