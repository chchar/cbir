% Works to obtain the first 'n' energies of the passed grayscale image...

% ------------------------------------------------------------
% Executes on being called, with input matrix & constant 'n'.
% ------------------------------------------------------------
function value = obtainEnergies(iMatrix, n)

dm = iMatrix;       % The matrix to be decomposed...

energies = [];

i = 1;

for j = 1:5
    [tl, tr, bl, br] = decompose(dm);

    energies(i) = energyLevel(tl);
    energies(i+1) = energyLevel(tr);
    energies(i+2) = energyLevel(bl);
    energies(i+3) = energyLevel(br);
    
    i = i + 4;
    dm = tl;
end
    
%Obtain array of energies...
sorted = -sort(-energies);      % Sorted in descending order...
value = sorted(1:n);

% ------------------------------------------------------------