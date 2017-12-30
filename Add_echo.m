%--------------------------------------------------------------------------
% Created: 10/7/14 by William J. Ebel (All Rights Reserved)
% 
% Revision History: None
% 
% Purpose: This function addes in an echo into an audio signal.  The echo
%   strength and delay are user parameters which must be in the range as
%   follows:
%      alpha - [0.1 0.6] echo strength
%      tau   - [0.05 0.5] echo delay (seconds)
% 
% Variables: 
%   t     - (input) time vector for the audio signal
%   x     - (input) sample vector for the audio signal 
%   alpha - (input) echo strength estimate for the echo
%   tau   - (input) time delay estimate for the echo
%
%   y - (output) samples vector for the audio with the echo, paired with t
% 
% function y = Add_echo(t,x,alpha,tau)
%--------------------------------------------------------------------------
function y = Add_echo(t,x,alpha,tau)

t = t(:)';   % Convert to a row vector
x = x(:)';   % Convert to a row vector

y = [];
% Check to make sure the parameters are OK
if size(t) ~= size(x)
  disp('*** ERROR. In Add_echo.  The time vector and samples vector are not the same size')
  return;
end
if (alpha > 0.6) || (alpha < 0.1)
  disp('*** ERROR. In Add_echo.  The alpha parameter is out of bounds. ')
  return;
end
if (tau > 0.5) || (tau < 0.05)
  disp('*** ERROR. In Add_echo.  The tau parameter is out of bounds. ')
  return;
end

% Create the impulse response for the echo system
T = t(2) - t(1);
th = 0:T:tau;
h = dc(th) + alpha*dc(th-tau);

% Filter the audio signal to create the audio with the echo and play it
y = myconv(t,x,th,h);
%myplay(t,y);

end