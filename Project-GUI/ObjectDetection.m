function varargout = ObjectDetection(varargin)
% ObjectDetection MATLAB code for ObjectDetection.fig
%      ObjectDetection, by itself, creates a new ObjectDetection or raises the existing
%      singleton*.
%
%      H = ObjectDetection returns the handle to a new ObjectDetection or the handle to
%      the existing singleton*.
%
%      ObjectDetection('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ObjectDetection.M with the given input arguments.
%
%      ObjectDetection('Property','Value',...) creates a new ObjectDetection or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ObjectDetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ObjectDetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ObjectDetection

% Last Modified by GUIDE v2.5 18-Aug-2016 22:59:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ObjectDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @ObjectDetection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ObjectDetection is made visible.
function ObjectDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ObjectDetection (see VARARGIN)

% Choose default command line output for ObjectDetection
handles.output = hObject;

%Create tab group
%uitab.BackgroundColor = [.5 .5 .5];
handles.tgroup = uitabgroup('Parent', handles.figure1);
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', ...
    '                                          Training                                          ');
handles.tab2 = uitab('Parent', handles.tgroup, 'Title', ...
    '                                          Testing                                          ');


%Place panels into each tab
set(handles.P1,'Parent',handles.tab1)
set(handles.P2,'Parent',handles.tab2)

%Reposition each panel to same location as panel 1
set(handles.P2,'position',get(handles.P1,'position'));

% Setup UI
% Browse Icon
browse_icon = imread('browse_icon.jpg');
browse_icon = imresize(browse_icon, [25 25]);
set(handles.load_images_browse,'cdata',browse_icon);

% Setup SIFT
% setup_sift;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ObjectDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ObjectDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_images_btn.
function load_images_btn_Callback(hObject, eventdata, handles)
% hObject    handle to load_images_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function load_images_edit_Callback(hObject, eventdata, handles)
% hObject    handle to load_images_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_images_edit as text
%        str2double(get(hObject,'String')) returns contents of load_images_edit as a double


% --- Executes during object creation, after setting all properties.
function load_images_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_images_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Display default location in load_images_edit_text_box
rootfolder = fullfile(pwd,'objectCategories');
% handles.load_images_edit = 'Default';
set(hObject,'String',rootfolder);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_images_browse.
function load_images_browse_Callback(hObject, eventdata, handles)
% hObject    handle to load_images_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function train_edit_Callback(hObject, eventdata, handles)
% hObject    handle to train_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of train_edit as text
%        str2double(get(hObject,'String')) returns contents of train_edit as a double


% --- Executes during object creation, after setting all properties.
function train_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to train_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in train_btn.
function train_btn_Callback(hObject, eventdata, handles)
% hObject    handle to train_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
