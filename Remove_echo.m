%-------------------------------------------------------------------
%Created: 09/05/2014 by Elizabeth Brennan, Jiean Lou, Steven Curran (All Rights Reserved)
%
%Revision History:  None
%
%Purpose: To reduce echo in audio signal
%
%Variables: 
%   y - input vector of audio signal
%   t - input vector of time values corresponding to r
%   alpha - output value of scalar representing echo wave strength factor
%   tau - output value of scalar representing echo delay factor
%   z - output vector of audio signal with reduced echo
%function [alpha tau z] = Remove_echo(t, y)
%-------------------------------------------------------------------


function [alpha tau z] = Remove_echo(t, y)
        alpha = [];
        tau = [];
        z = [];    
if (length(t) ~= length(y))
        
        return;
    else
       %Find autocorrelation function
       [tR Ry] = Rxx(t, y);
       
       %Get tau from Ry graph:
       T = t(2) - t(1);


%create autocorrelation function
[tR Ry] = Rxx(t,y);
Ry = Ry/max(Ry); %normalize to max wave at origin is 1

tR = round(tR/T); %make tR in terms of integers
%create range of tR that tau might equal
index1 = find(tR == 0.04/T); %find beginning of interval of possible taus
index2 = find(tR == 0.6/T); %end of range that tau might be

Ry2 = Ry(index1:index2); %make Ry within the interval
tR2 = tR(index1:index2); %shorten tR2, too

m = max(Ry2); %find highest point of new vector
index3 = find(Ry2==m); %locate position index where max occurs
tau = tR2(index3) * T; %multiply by T to get it back to normal

           %Get alpha once tau is known:
       ratio = Ry(find(tR==(tR2(index3))))/Ry((find(tR==0)));
       alpha = -.2327*ratio.^5 + 1.0994*ratio.^4 + -1.4411*ratio.^3 + .1040*ratio.^2 + .9801*ratio + -.0029;
         
       %Toss alpha and tau into impulse response that will be used to
       %remove the echo
       th = 0:T:tau;
       hi = dc(th) - alpha*dc(th-tau);
       
       %Perform convolution on the original signal with the impulse
       %response, hi
       z = myconv(t, y, th, hi);
        
    end
    end
