function varargout = Reinforcement(varargin)
% REINFORCEMENT MATLAB code for Reinforcement.fig
%      REINFORCEMENT, by itself, creates a new REINFORCEMENT or raises the existing
%      singleton*.
%
%      H = REINFORCEMENT returns the handle to a new REINFORCEMENT or the handle to
%      the existing singleton*.
%
%      REINFORCEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REINFORCEMENT.M with the given input arguments.
%
%      REINFORCEMENT('Property','Value',...) creates a new REINFORCEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Reinforcement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Reinforcement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Reinforcement

% Last Modified by GUIDE v2.5 20-Aug-2016 03:04:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Reinforcement_OpeningFcn, ...
                   'gui_OutputFcn',  @Reinforcement_OutputFcn, ...
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


% --- Executes just before Reinforcement is made visible.
function Reinforcement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Reinforcement (see VARARGIN)

% Choose default command line output for Reinforcement
handles.output = hObject;
global img_path bounding_rect descp histogram_temp im total count wrong_flag wrong_flag_recent imgSets reinf_histogram2


reinf_histogram2 = {};
reinf_histogram2{1,1} = [];
reinf_histogram2{1,2} = [];
img_path = load('path.mat');
img_path = img_path.path;
load('bounding_rect.mat','bounding_rect');
load('descp.mat','descp');
load('histogram_temp.mat','histogram_temp');
valtuk = histogram_temp;
load('imgSets.mat','imgSets');


set(handles.radiobutton1,'String','coins');
set(handles.radiobutton2,'String','keys');
set(handles.radiobutton3,'String','pendrive');
set(handles.radiobutton4,'String','Negative image');
set(handles.radiobutton5,'String','Localization Failure');

set(handles.uibuttongroup1,'Visible','off');
set(handles.pushbutton1,'Visible','off');
total = length(bounding_rect);
count = 1;
wrong_flag = 0;
wrong_flag_recent = 0;

if(total==1)
    set(handles.pushbutton1,'String','Finish');
end

im = imread(img_path);
    thisBB = bounding_rect(count).BoundingBox;
    test_image = imcrop(im, [thisBB(1),thisBB(2),thisBB(3),thisBB(4)]);
    
    axes(handles.axes1);

    imshow(test_image);
    if(descp(count,1)>3)
    text = 'I Do Not Know';
    val = 4;
    else
        text = imgSets(1,descp(count,1)).Description;
        val = descp(count,1);
    end
    set(handles.text2,'String',text);
    
    % set(handles.uibuttongroup1,'SelectedObject',
   
    % val = get(handles.uibuttongroup1,'SelectedObject');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Reinforcement wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Reinforcement_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wrong_flag wrong_flag_recent reinf_histogram2 histogram_temp end_flag count imgSets file_path


if(wrong_flag_recent == 1)
address = get(handles.uibuttongroup1,'SelectedObject');
text = get(address,'String');

if (strcmp(text,'coins'))
    value = 1;
elseif(strcmp(text,'keys'))
    value = 2;
elseif(strcmp(text,'pendrive'))
    value = 3;
elseif(strcmp(text,'Negative image'))
    value = 4;
else
    set(handles.uibuttongroup1,'Visible','off');
set(handles.pushbutton1,'Visible','off');
set(handles.correct_btn,'Visible','on');
set(handles.correct_btn,'String','Next');
set(handles.wrong_btn,'Visible','off');

    return;
end
set(handles.text2,'String',text);
reinf_histogram2{1,1} = [reinf_histogram2{1,1};histogram_temp(count,:)];
reinf_histogram2{1,2} = [reinf_histogram2{1,2};value];
        
wrong_flag_recent = 0;
set(handles.uibuttongroup1,'Visible','off');
set(handles.pushbutton1,'Visible','off');
set(handles.correct_btn,'Visible','on');
set(handles.correct_btn,'String','Next');
set(handles.wrong_btn,'Visible','off');
    
    return;

end

if(end_flag == 1)
if(wrong_flag == 1)
    
    
    file_path = fullfile('objectCategories','reinf_histogram.mat');
        if ~exist(file_path,'file')
            reinf_histogram = reinf_histogram2;
            save(file_path,'reinf_histogram');
            
        else
            load('objectCategories\reinf_histogram');
            reinf_histogram{1,1} = [reinf_histogram{1,1}; ...
                                    reinf_histogram2{1,1}];
            reinf_histogram{1,2} = [reinf_histogram{1,2}; ...
                                    reinf_histogram2{1,2}];
            save(file_path,'reinf_histogram');
            
        end
        wrong_flag = 0;
end

trained_models = object_det_4();
% save('trained_models.mat','trained_models');
save('trained_models.mat','trained_models');


set(handles.pushbutton1,'Enable','off');
% close(hFig);
end
    

% --- Executes on button press in correct_btn.
function correct_btn_Callback(hObject, eventdata, handles)
% hObject    handle to correct_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count total im end_flag bounding_rect descp imgSets
end_flag = 0;
count = count + 1;
if(count>total)
    end_flag = 1;
    set(handles.uibuttongroup1,'Visible','off');
set(handles.pushbutton1,'Visible','on');
set(handles.pushbutton1,'String','Finish');
set(handles.correct_btn,'Visible','off');
set(handles.wrong_btn,'Visible','off');
return;
end

set(handles.uibuttongroup1,'Visible','off');
set(handles.pushbutton1,'Visible','off');
set(handles.correct_btn,'String','Correct');
set(handles.correct_btn,'Visible','on');
set(handles.wrong_btn,'Visible','on');
thisBB = bounding_rect(count).BoundingBox;
    test_image = imcrop(im, [thisBB(1),thisBB(2),thisBB(3),thisBB(4)]);
    
     axes(handles.axes1);
    imshow(test_image);
    %btext=imgSets(1,3).Description;
    if(descp(count,1)>3)
    btext = 'I Do Not Know';
    val = 4;
    else
        btext = imgSets(1,descp(count,1)).Description;
        val = descp(count,1);
    end
    set(handles.text2,'String',btext);



% --- Executes on button press in wrong_btn.
function wrong_btn_Callback(hObject, eventdata, handles)
% hObject    handle to wrong_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wrong_flag count total wrong_flag_recent
wrong_flag = 1;
% if(count == total)
%     set(handles.pushbutton1,'String','Finish');
% end
set(handles.pushbutton1,'String','Okay');
set(handles.pushbutton1,'Visible','on');
set(handles.uibuttongroup1,'Visible','on');
set(handles.correct_btn,'Visible','off');
set(handles.wrong_btn,'Visible','off');

wrong_flag_recent = 1;
