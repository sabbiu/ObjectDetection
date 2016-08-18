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

% Last Modified by GUIDE v2.5 18-Aug-2016 06:32:52

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
handles.tgroup = uitabgroup('Parent', handles.figure1,'TabLocation', 'top');
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'Training');
handles.tab2 = uitab('Parent', handles.tgroup, 'Title', 'Testing');

%Place panels into each tab
set(handles.P1,'Parent',handles.tab1)
set(handles.P2,'Parent',handles.tab2)

%Reposition each panel to same location as panel 1
set(handles.P2,'position',get(handles.P1,'position'));


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
