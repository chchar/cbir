% Works to obtain the energy level of the passed matrix...

% ------------------------------------------------------------
% Executes on being called, with input matrix.
% ------------------------------------------------------------
function value = energyLevel(aMatrix)

% Obtain the Matrix elements... r - rows, c - columns.
[r, c] = size(aMatrix);

%Obtain energyLevel...
value = sum(sum(abs(aMatrix)))/(r*c);

% ------------------------------------------------------------
