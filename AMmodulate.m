%-------------------------------------------------------------
% Created: 9/8/2014 by Joshua R. Beckwith and Kwadwo Gray
%
% Revision History: None
%
% Purpose: This function takes in an audio signal and modulates it
%
% Variables: 
%   t       - time
%   x       - audio signal
%   BW      - bandwidth for butterfilter
%   Order   - define the filter (4,10)
%   fc      - cutoff frequency
%   a       - modulation index
%   xAM     - modulated signal
%   
% function xAM = AMmodulate(t,x,BW,Order,fc,a)

function xAM = AMmodulate(t,x,BW,Order,fc,a);

fn = BW/(264600*0.5);

[b0, a0] = butter(Order, fn);   % Lowpass filter

xn = (filter(b0, a0, x))/(abs(min(filter(b0, a0, x)))); % Normalize
xAM = ((xn * a) + 1).*cos((2*pi*fc).*t);    % Calculate modulation