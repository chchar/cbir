function varargout = Demo(varargin)

% ------------------------------------------------------------
%   DEMO Application M-file for Demo.fig
%   DEMO, by itself, creates a new DEMO or raises the existing
%   singleton*.
%
%   H = DEMO returns the handle to a new DEMO or the handle to
%   the existing singleton*.
%
%   DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%   function named CALLBACK in DEMO.M with the given input arguments.
%
%   DEMO('Property','Value',...) creates a new DEMO or raises the
%   existing singleton*.  Starting from the left, property value pairs are
%   applied to the GUI before Demo_OpeningFunction gets called.  An
%   unrecognized property name or invalid value makes property application
%   stop.  All inputs are passed to Demo_OpeningFcn via varargin.
%
%   *See GUI Options - GUI allows only one instance to run (singleton).
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo

% Last Modified by GUIDE v2.5 21-Oct-2002 03:11:52
% ------------------------------------------------------------



% ------------------------------------------------------------
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',          mfilename, ...
                   'gui_Singleton',     gui_Singleton, ...
                   'gui_OpeningFcn',    @Demo_OpeningFcn, ...
                   'gui_OutputFcn',     @Demo_OutputFcn, ...
                   'gui_LayoutFcn',     [], ...
                   'gui_Callback',      []);



if nargin == 0   % LAUNCH GUI
	initial_dir = pwd;

% Open FIG-file
fig = openfig(mfilename,'reuse');	% Generate a structure of handles to pass to callbacks, and store it. 
handles = guihandles(fig);
guidata(fig, handles);

%disp('populate1!!');

% Populate the listbox
load_listbox(initial_dir,handles)

% Return figure handle as first output argument
    if nargout > 0
    	varargout{1} = fig;
    end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end


% End initialization code - DO NOT EDIT
% ------------------------------------------------------------


% ------------------------------------------------------------
% Executes just before Demo is made visible.
% ------------------------------------------------------------
function Demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo (see VARARGIN)

% Choose default command line output for Demo...
handles.output = hObject;

% Initialize the options...
handles.option = 'input';

% Update handles structure...
guidata(hObject, handles);

% ------------------------------------------------------------



% ------------------------------------------------------------
% Outputs from this function are returned to the command line.
% ------------------------------------------------------------
function varargout = Demo_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% ------------------------------------------------------------



% ------------------------------------------------------------
% Callback for list box - open .fig with guide, otherwise use open
% ------------------------------------------------------------
function varargout = listbox1_Callback(h, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

mouse_event = get(handles.figure1,'SelectionType');
index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');	
filename = file_list{index_selected};

if strcmp(mouse_event,'normal')
    if ~handles.is_dir(handles.sorted_index(index_selected)) 
        [newpath, name, ext, ver] = fileparts(filename);
        switch ext
            case '.BMP'
                set(handles.selectButton, 'Enable', 'On');
            case '.bmp'
                set(handles.selectButton, 'Enable', 'On');
            otherwise
                set(handles.selectButton, 'Enable', 'Off');
        end
    end
end

if strcmp(mouse_event,'open')
	if  handles.is_dir(handles.sorted_index(index_selected))
		cd (filename)
		load_listbox(pwd,handles)
    end
end
    
% ------------------------------------------------------------



% ------------------------------------------------------------
% Read the current directory and sort the names
% ------------------------------------------------------------
function load_listbox(dir_path,handles)
cd (dir_path)
dir_struct = dir(dir_path);
[sorted_names,sorted_index] = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
handles.is_dir = [dir_struct.isdir];
handles.sorted_index = [sorted_index];
guidata(handles.figure1,handles)
set(handles.listbox1,'String',handles.file_names,...
	'Value',1)
set(handles.text1,'String',pwd)

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes during object creation, after setting all properties.
% ------------------------------------------------------------
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes during object creation, after setting all properties.
% ------------------------------------------------------------
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes on selection change in popupmenu.
% ------------------------------------------------------------
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu

val = get(hObject,'Value');
str = get(hObject, 'String');
cd(str{val});

load_listbox(pwd, handles)

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes on selection of 'Quite' from the menubar.
% ------------------------------------------------------------
function quite_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = questdlg('Are you sure you want to quite?',...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes on selection of 'Input To Database' from the menubar.
% ------------------------------------------------------------
function inputDatabase_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Some code to input the selected image to the database...

set(handles.input, 'Checked', 'On');
set(handles.search, 'Checked', 'Off');

set(handles.listbox1, 'Enable', 'On');
set(handles.text1, 'Enable', 'On');
set(handles.popupmenu, 'Enable', 'On');

handles.option = 'input';       % This means that the option is to "input to database"...

guidata(hObject, handles)

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes on selection of 'Search Database' from the menubar.
% ------------------------------------------------------------
function searchDatabase_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Some code to search the database for the selected image...

set(handles.input, 'Checked', 'Off');
set(handles.search, 'Checked', 'On');

set(handles.listbox1, 'Enable', 'On');
set(handles.text1, 'Enable', 'On');
set(handles.popupmenu, 'Enable', 'On');

handles.option = 'search';      % This means that the option is to "search database"...

guidata(hObject, handles)

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes on button press in selectbutton.
% ------------------------------------------------------------
function selectButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');	
filename = file_list{index_selected};

[newpath,name,ext,ver] = fileparts(filename);

handles.filename = strcat(name,ext);

[handles.queryx, handles.querymap] = imread(filename);    %read the image file.

%save this in a global variable

%QImage=imread(filename);

% cd('C:\Project');
cd('C:\Documents and Settings\Administrator\My Documents\MATLAB\Code,Image DB\finalapplication');

figure

imshow(handles.queryx, handles.querymap); %This displays the image.

% Obtain HSV format of the image...
handles.queryhsv = rgb2hsv(handles.querymap);

handles.querygray = rgb2gray(handles.querymap);

guidata(hObject,handles)

set(handles.selectButton, 'Enable', 'Off');

set(handles.listbox1, 'Enable', 'Off');
set(handles.text1, 'Enable', 'Off');
set(handles.popupmenu, 'Enable', 'Off');

set(handles.input, 'Enable', 'Off');
set(handles.search, 'Enable', 'Off');

% handles.option

switch handles.option
case 'input'
    set(handles.inputButton, 'Enable', 'On');
case 'search'
    set(handles.searchButton, 'Enable', 'On');
end

% ------------------------------------------------------------


% ------------------------------------------------------------
% Executes on button press in inputButton.
% ------------------------------------------------------------
function inputButton_Callback(hObject, eventdata, handles)
% hObject    handle to transform1button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.inputButton, 'Enable', 'Off');

% Open database txt file... for reading...
fid = fopen('database.txt');

exists = 0;

while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end       % Meaning: End of File...
    if (strcmp(tline, handles.filename))
        exists = 1;
        break;
    end
        
end

fclose(fid);

if ~exists
    fid = fopen('database.txt', 'a');
    fprintf(fid,'%s\r',handles.filename);
    fclose(fid);
end

guidata(hObject, handles)

msgbox('Database updated with file name...', 'Success...');


set(handles.input, 'Checked', 'Off');
set(handles.search, 'Checked', 'Off');
set(handles.input, 'Enable', 'On');
set(handles.search, 'Enable', 'On');

% ------------------------------------------------------------



% ------------------------------------------------------------
% Executes on button press in searchButton.
% ------------------------------------------------------------
function searchButton_Callback(hObject, eventdata, handles)
% hObject    handle to transform2button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.searchButton, 'Enable', 'Off');

% Colour search...

% Open database txt file... for reading...
fid = fopen('database.txt');

resultValues = [];      % Results matrix...
resultNames = {};
i = 1;                  % Indices...
j = 1;

while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end       % Meaning: End of File...
    
    [X, RGBmap] = imread(imagename);
    HSVmap = rgb2hsv(RGBmap);
    
    D = quadratic(handles.queryx, handles.querymap, X, HSVmap);
    resultValues(i) = D;
    resultNames(j) = {imagename};
    i = i + 1;
    j = j + 1;
end

fclose(fid);


% Sorting colour results...

[sortedValues, index] = sort(resultValues);     % Sorted results... the vector index
 % is used to find the resulting files.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%here we plot color results 
%
figure;
h = stem(sortedValues,'fill','--');
set(h,'MarkerFaceColor','red');title('Color Distance of each image')
%
%
fid = fopen('colourResults.txt', 'w+');         % Create a file, over-write old ones.

for i = 1:10        % Store top 10 matches...
    tempstr = char(resultNames(index(i)));
    fprintf(fid, '%s\r', tempstr);
    
    disp(resultNames(index(i)));
    disp(sortedValues(i));
    disp('  ');
end

fclose(fid);

%return;

disp('Colour part done...');
disp('Colour results saved...');
disp('');

displayResults('colourResults.txt', 'Colour Results...');

disp('Texture part starting...');

% Texture search...

queryEnergies = obtainEnergies(handles.queryx, 6);          % Obtain top 6 energies of the image.

% Open colourResults txt file... for reading...
 fid = fopen('colourResults.txt');
% fid = fopen('database.txt');


fresultValues = [];      % Results matrix...
fresultNames = {};
i = 1;                  % Indices...
j = 1;

while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end       % Meaning: End of File...
    
    [X, RGBmap] = imread(imagename);
    
    imageEnergies = obtainEnergies(X, 6);
    
    E = euclideanDistance(queryEnergies, imageEnergies);
    
    fresultValues(i) = E;
    fresultNames(j) = {imagename};
    i = i + 1;
    j = j + 1;
end

fclose(fid);
disp('Texture results obtained...');

% Sorting final results...

[sortedValues, index] = sort(fresultValues);     % Sorted results... the vector index is used to find the resulting files.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%here we plot texture results
%
figure;
h = stem(sortedValues,'fill','--');
set(h,'MarkerFaceColor','red');title('Texture Distance of each image')   
%
%

fid = fopen('textureResults.txt', 'w+');         % Create a file, over-write old ones.

for i = 1:6        % Store top 5 matches...
    imagename = char(fresultNames(index(i)));
    fprintf(fid, '%s\r', imagename);
    
    disp(imagename);
    disp(sortedValues(i));
    disp('  ');
  
end

fclose(fid);
disp('Texture results saved...');

displayResults('textureResults.txt', 'Texture Results...');

%%%%%%----------------------------------------------%%%%%%%
%%%%%%%%%%%%%%%%%%%MOMENTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%---------------------------------------------%%%%%%%
% [Q,map]= imread(handles.filename);
% whos map
% QImage= rgb2gray(map);
QImage=~im2bw(handles.querygray);%convert image to binary
Qcentroids=apply_moments(QImage);


%get texture results or database
fid = fopen('textureResults.txt');
% fid = fopen('database.txt');
MresultValues = [];      % Results matrix...
MresultNames = {};
i = 1;                  % Indices...
j = 1;
   
    
while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end       % Meaning: End of File...
    
    [X,map] = imread(imagename);
    Image= rgb2gray(map);
    Image=~im2bw(Image);%convert image to binary
    centroids=apply_moments(Image);
    
    E = euclideanDistance(Qcentroids, centroids);
    
    MresultValues(i) = E;
    MresultNames(j) = {imagename};
    i = i + 1;
    j = j + 1;
   
end


fclose(fid);
disp('Moments results obtained...');

% Sorting final results...

[sortedValues, index] = sort(MresultValues);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%here we plot moments results
%
figure;
h = stem(sortedValues,'fill','--');
set(h,'MarkerFaceColor','red');title('Moments Distance of each image')   
%
%

fid = fopen('momentResults.txt', 'w+');         % Create a file, over-write old ones.

for i = 1:4       % Store top 3 matches...
    imagename = char(MresultNames(index(i)));
    fprintf(fid, '%s\r', imagename);
    
    disp(imagename);
    disp(sortedValues(i));
    disp('  ');
  
end

fclose(fid);
disp('Moments results saved...');
displayResults('momentResults.txt', 'Moment Results...');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

guidata(hObject,handles)

set(handles.input, 'Checked', 'Off');
set(handles.search, 'Checked', 'Off');
set(handles.input, 'Enable', 'On');
set(handles.search, 'Enable', 'On');

% ------------------------------------------------------------
