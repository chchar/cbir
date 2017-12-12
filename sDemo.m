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

% Choose default command line output for Demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Have the default path set to the C:\ drive
cd('C:\');
initial_dir = pwd;

% Populate the listbox
load_listbox(initial_dir, handles)

% ------------------------------------------------------------


% UIWAIT makes Demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
            case '.png'
                set(handles.selectbutton, 'Enable', 'On');
            case '.pcx'
                set(handles.selectbutton, 'Enable', 'On');
            case '.bmp'
                set(handles.selectbutton, 'Enable', 'On');
            case '.tiff'
                set(handles.selectbutton, 'Enable', 'On');
            case '.jpeg'
                set(handles.selectbutton, 'Enable', 'On');
            case '.jpg'
                set(handles.selectbutton, 'Enable', 'On');
            case '.JPG'
                set(handles.selectbutton, 'Enable', 'On');                
            case '.gif'
                set(handles.selectbutton, 'Enable', 'On');
            case '.GIF'
                set(handles.selectbutton, 'Enable', 'On');
            otherwise
                set(handles.selectbutton, 'Enable', 'Off');
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
% Executes on button press in selectbutton.
% ------------------------------------------------------------
function selectbutton_Callback(hObject, eventdata, handles)
% hObject    handle to selectbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

index_selected = get(handles.listbox1,'Value');
file_list = get(handles.listbox1,'String');	
filename = file_list{index_selected};

[newpath,name,ext,ver] = fileparts(filename);

handles.image = imread(filename); %read the image file.
figure
colormap(gray);
imshow(handles.image); %This displays the image.

guidata(hObject,handles)

set(handles.selectbutton, 'Enable', 'Off');
set(handles.listbox1, 'Enable', 'Off');
set(handles.text1, 'Enable', 'Off');
set(handles.popupmenu, 'Enable', 'Off');
set(handles.histogrambutton, 'Enable', 'On');
% ------------------------------------------------------------


% ------------------------------------------------------------
% Executes on button press in transform1button.
% ------------------------------------------------------------
function transform1button_Callback(hObject, eventdata, handles)
% hObject    handle to transform1button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Perform 1st level decomposition...
[handles.A, handles.B, handles.C, handles.D] = dwt2(handles.image,'db1');

% Obtain energy levels...
handles.energyA = energyLevel(handles.A)
handles.energyB = energyLevel(handles.B)
handles.energyC = energyLevel(handles.C)
handles.energyD = energyLevel(handles.D)


% Obtain the maximum energy level...
x = [handles.energyA, handles.energyB, handles.energyC, handles.energyD];
[d, i] = max(x);

switch i
case 1
    handles.maxEComponent = 'A';
case 2
    handles.maxEComponent = 'B';
case 3
    handles.maxEComponent = 'C';
case 4
    handles.maxEComponent = 'D';
end


handles.cod_A = wcodemat(handles.A);
handles.cod_B = wcodemat(handles.B);
handles.cod_C = wcodemat(handles.C);
handles.cod_D = wcodemat(handles.D);

figure
colormap(gray)
imagesc([handles.cod_A, handles.cod_B; handles.cod_C, handles.cod_D]);

guidata(hObject, handles)

set(handles.transform1button, 'Enable', 'Off');
set(handles.transform2button, 'Enable', 'On');

% ------------------------------------------------------------


% ------------------------------------------------------------
% Executes on button press in transform2button.
% ------------------------------------------------------------
function transform2button_Callback(hObject, eventdata, handles)
% hObject    handle to transform2button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


switch handles.maxEComponent
case 'A'
    [handles.A2,handles.B2,handles.C2,handles.D2] = dwt2(handles.A,'db1');
case 'B'
    [handles.A2,handles.B2,handles.C2,handles.D2] = dwt2(handles.B,'db1');
case 'C'
    [handles.A2,handles.B2,handles.C2,handles.D2] = dwt2(handles.C,'db1');
case 'D'
    [handles.A2,handles.B2,handles.C2,handles.D2] = dwt2(handles.D,'db1');
end

handles.cod_A2 = wcodemat(handles.A2);
handles.cod_B2 = wcodemat(handles.B2);
handles.cod_C2 = wcodemat(handles.C2);
handles.cod_D2 = wcodemat(handles.D2);

% Obtain energy levels...
handles.energyA2 = energyLevel(handles.A2)
handles.energyB2 = energyLevel(handles.B2)
handles.energyC2 = energyLevel(handles.C2)
handles.energyD2 = energyLevel(handles.D2)



cod_decomp2 = [handles.cod_A2,handles.cod_B2;handles.cod_C2,handles.cod_D2];

%scrsz = get(0,'ScreenSize');
%figure('Position',[30 scrsz(4)/2+10 scrsz(3)/2 scrsz(4)/2]);
figure
colormap(gray);


switch handles.maxEComponent
case 'A'
    imagesc([cod_decomp2, handles.cod_B; handles.cod_C, handles.cod_D]);
case 'B'
    imagesc([handles.cod_A, cod_decomp2; handles.cod_C, handles.cod_D]);
case 'C'
    imagesc([handles.cod_A, handles.cod_B; cod_decomp2, handles.cod_D]);
case 'D'
    imagesc([handles.cod_A, handles.cod_B; handles.cod_C, cod_decomp2]);
end

guidata(hObject,handles)

set(handles.transform2button, 'Enable', 'Off');
set(handles.listbox1, 'Enable', 'On');
set(handles.text1, 'Enable', 'On');
set(handles.popupmenu, 'Enable', 'On');

% ------------------------------------------------------------


% ------------------------------------------------------------
% Executes on button press in histogrambutton.
% ------------------------------------------------------------
function histogrambutton_Callback(hObject, eventdata, handles)
% hObject    handle to transform2button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



try
    % Histogram code...
    [X, handles.map] = rgb2ind(handles.image,20);
    [handles.counts, x] = imhist(X,handles.map);
    
    figure, imhist(X,handles.map);
    
    handles.counts
    handles.map
    
    %convert to grayscale
    I = rgb2gray(handles.image);
    handles.image = I;
    figure
    imshow(I);
    
catch
    % Don't do anything... This is incase it turns out not to be an rgb image, but a grayscale image already.
end


guidata(hObject,handles)

set(handles.histogrambutton, 'Enable', 'Off');
set(handles.transform1button, 'Enable', 'On');

% ------------------------------------------------------------
