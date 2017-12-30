%-------------------------------------------------------------
% Created: 9/8/2014 by Joshua R. Beckwith, Kwadwo Gray
%                      Elizabeth Brennan, and Deanna Jacobson
%
% Revision History: None
%
% Purpose: This function takes in an audio signal and modulates it
%
% Variables: 
%   t       - time
%   RF      - modulated signal
%   BW      - bandwidth for butterfilter
%   Order   - define the filter (4,10)
%   fc      - carrier frequency
%   y       - demodulated signal
%   
% function y = AMdemodulate(t, RF, BW, Order, fc)

function y = AMdemodulate(t, RF, BW, Order, fc)

if (length(t) ~= length(RF))
   y = [];
   return
end

% Grab the audio sample
f1 = fc - BW/2;
f2 = fc + BW/2;
fn = [f1 f2]/(264600*0.5);
[b a] = butter(Order,fn);
rfFilter = filter(b,a,RF);

% RF squared
rfSquared = rfFilter.^2;

% low pass filter
fn = (BW)/(264600*0.5);
[b0, a0] = butter(Order, fn);
lpfRF =  filter(b0, a0, rfSquared);

% Square root
sqrtRF = lpfRF.^(0.5);

% Chop DC
y = sqrtRF - mean(sqrtRF);
y(1:26460) = 0;
y(length(y)-26460:end) = 0;
y = y/(max(abs(y)));