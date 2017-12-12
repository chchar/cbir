% Works to display the images named in a text file passed to it...

% ------------------------------------------------------------
% Executes on being called, with inputs:
%       filename -  the name of the text file that has the 
%                   list of images
%       header -    the figure header name
% ------------------------------------------------------------
function displayResults(filename, header)

figure('Position',[200 100 700 400], 'MenuBar', 'none', 'Name', header, 'Resize', 'off', 'NumberTitle', 'off');

% Open 'filename' file... for reading...
fid = fopen(filename);

i = 1;                  % Subplot index on the figure...

while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end       % Meaning: End of File...
    
    [x, map] = imread(imagename);
    
    subplot(2,5,i);
    subimage(x, map);
    xlabel(imagename);
    
    i = i + 1;
   
end

fclose(fid);
%--------------------------------------------------------------