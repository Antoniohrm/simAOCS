%
% This function takes a quaternion array and switches the convention
% between q0 and q4, in either order
%
% It is assumed that if scalarId is set to 4, the position of the scalar
% term in qIn is 0 and vice versa
%
% If qIn presents the quaternions stacked by columns (4xn), qOut will too,
% and vice versa
%
% Inputs:
%   - qIn: 4xn or nx4 double array, quaternion(s) to convert
%   - scalarId: 1x1 double, requested position of the scalar term(s), 
%               either 0 or 4
%   - normQuat: 1x1 bool, whether to normalize the quaternion(s)
%
% Outputs:
%   - qOut: 4xn or nx4 array
%

function [qOut] = convertQuatConv(qIn, scalarId, normQuat)

%% Handle inputs

% Check needed inputs

if nargin < 2
    error('Not enough input arguments. Please provide qIn and scalarId.');
end

% Check value of scalarId

if ~any(scalarId == [0, 4])
    error('Scalar position shall be either 0 or 4');
end

% Check if normQuat was set

if nargin < 3
    normQuat = true; % Normalize quaternion by default
end

%% Convert qIn to 4xn if needed

szQ = size(qIn);

if length(szQ) == 2
    if szQ(1) == 4
        inpShape = 'byCols';
    elseif szQ(2) == 4
        inpShape = 'byRows';
        qIn = qIn'; % Transpose
    else
        error('None of the dimensions in qIn are equal to 4');
    end
else
    error('qIn must be a 2D matrix or vector');
end

%% Normalize if requested

if normQuat
    qIn = qIn ./ vecnorm(qIn);
end

%% Convert convention

switch scalarId

    case 0

        qOut = ... 
            [qIn(4, :); ... 
            qIn(1:3, :)];

    case 4

        qOut = ... 
            [qIn(2:4, :); ... 
            qIn(1, :)];

end

%% Recover input shape

if strcmpi(inpShape, 'byRows')
    qOut = qOut'; % Transpose back to original shape if needed
end

end