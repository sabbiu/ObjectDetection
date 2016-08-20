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

% Last Modified by GUIDE v2.5 19-Aug-2016 22:01:16

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
set(handles.testing_load_image_browse,'cdata',browse_icon);


global play_icon_off play_icon

play_icon = imread('run.jpg');
play_icon = imresize(play_icon, [36 36]);
set(handles.Test_play,'cdata',play_icon);

play_icon_off = imread('runoff.jpg');
play_icon_off = imresize(play_icon_off,[36 36]);
% set(handles.Test_play,'cdata',play_icon_off);


set(handles.train_btn,'Enable','off');
set(handles.load_images_btn,'Enable','on');
set(handles.image_edit_panel,'Visible','off');
% Setup SIFT
run('vlfeat-0.9.20\toolbox\vl_setup');


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

rootfolder = get(handles.load_images_edit,'String');

imgSets = imageSet(rootfolder,'recursive');
handles.imgSets = imgSets;
guidata(hObject,handles);
save('imgSets.mat','imgSets');
for i = 1:size(imgSets,2)
    
    categoryName = imgSets(1,i).Description;
    imageCount = imgSets(1,i).Count;
    string_to_disp = sprintf('%s%s %s%s   %s%s',num2str(i),'. ',categoryName,': ',num2str(imageCount),' training images');
    set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        string_to_disp));
end

 set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        'Images Loaded Successfully!!!',handles.line_in_msgdisp));
set(hObject,'Enable','off');
index = size(get(handles.Message_disp,'String'), 1);
set(handles.Message_disp,'Value',index);
set(handles.train_btn,'Enable','on');


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

folder_name = uigetdir(pwd,'Select folder with various Object Categories');
set(handles.load_images_edit,'String',folder_name);
set(handles.load_images_btn,'Enable','on');

set(handles.Message_disp,'String',strvcat('Object Detection',handles.line_in_msgdisp));


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


set(handles.animation_sift,'Backgroundcolor','y');
set(handles.animation_kmeans,'Backgroundcolor','y');
set(handles.animation_bow,'Backgroundcolor','y');
set(handles.animation_svm,'Backgroundcolor','y');

% SIFT started...
no_of_category = length(handles.imgSets);

for i=1:no_of_category
    no_of_images = length(handles.imgSets(:,i).ImageLocation);
    
    str1 = sprintf('%s %s%s %s','Image Category',num2str(i),':',handles.imgSets(:,i).Description);
    str2 = sprintf('No. of images = %4d',no_of_images);
    strn = ' ';
    
    drawnow
     set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        strn,str1,str2));
    stry = get(handles.Message_disp,'String');

    str3 = sprintf('Extracting SIFT features...\t %4d/%4d',1,no_of_images);
    for j=1:no_of_images
        str3 = sprintf(strcat(str3(1:29),'%4d/%4d'),j,no_of_images);
        
        file_path = char(handles.imgSets(1,i).ImageLocation(1,j));
        [pathstr,name,ext] = fileparts(file_path);
        descriptor = features_SIFT(file_path);
        save(char(strcat(pathstr,'\',name,'.mat')),'descriptor');
    
        drawnow
        set(handles.Message_disp,'String', ...
        strvcat(stry, ...
        str3));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);
    end
    
    
end


% variables ========
features_each = [];
features_category = [];
features_all = [];
% ==================
no_of_category = length(handles.imgSets);
count = 0;
for i=1:no_of_category
    no_of_images = length(handles.imgSets(:,i).ImageLocation);
    
    for j=1:no_of_images
        file_path = char(handles.imgSets(1,i).ImageLocation(1,j));
        [pathstr,name,ext] = fileparts(file_path);
        load(char(strcat(pathstr,'\',name,'.mat')),'descriptor');
        descriptor = double(descriptor)/255;
        features_all = [features_all; descriptor];
        count = count + size(descriptor,1);
        features_each = [features_each; count];
    end
    features_category = [features_category; count];
end

set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        ' ','Total number of features extracted: ',num2str(count)));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);

drawnow
  set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        ' ','SIFT features extracted successfully!!',handles.line_in_msgdisp));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);

% SIFT ended

drawnow
set(handles.animation_sift,'Backgroundcolor','g');
drawnow


% kmeans started

clusters = 500;
iteration = 100;

set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        'Starting K Means Clustering...', ...
        'This might take 1 or 2 minutes depending on your processor',' '));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);
drawnow
        
        
% using library

[centers, dist_n_val] = vl_kmeans(features_all',clusters);
dist_n_val = double(dist_n_val');
for i = 2:(clusters+2)
dist_n_val(:,i)=dist_n_val(:,1);
end
centers = centers';
% ======================
% without using library
% [centers, dist_n_val] = kmeans(features_all, clusters, iteration);
% =========================
set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        'Done With K Means Clustering!!',handles.line_in_msgdisp));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);
drawnow

save('cluster_centers','centers');
save('cluster_values','dist_n_val');
save('features_all','features_all');
save('features_each','features_each');
save('features_category','features_category');

% kmeans ended

set(handles.animation_kmeans,'Backgroundcolor','g');

drawnow
% bow started

set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        'Creating Bag Of Visual Words...', ...
       ' '));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);
drawnow

img_cnt = 1;
img_each = 0;
category_cnt = 1;
histogram = zeros(1,clusters);

for i=1:size(features_all,1)
    
    location = dist_n_val(i,clusters+1);
    histogram(1,location) = histogram(1,location) + 1;
    if(i == features_each(img_cnt,1))
        histogram = histogram/norm(histogram);
        file_path = char(handles.imgSets(1,category_cnt).ImageLocation(1,img_cnt-img_each));
        [pathstr,name,ext] = fileparts(file_path);
        save(char(strcat(pathstr,'\histograms\',name,'hist.mat')),'histogram');
        
        
        if(i == features_category(category_cnt,1))
            img_each = img_cnt;
            category_cnt = category_cnt + 1;
        end
        
        img_cnt = img_cnt + 1;
        histogram = zeros(1,clusters);
        
    end
    
end

set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        'Bag of Visual Words Created!!',handles.line_in_msgdisp));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);
drawnow


% bow ended

set(handles.animation_bow,'Backgroundcolor','g');

drawnow
% svm started
trained_models = object_det_4();
save('trained_models.mat','trained_models');

 set(handles.Message_disp,'String', ...
        strvcat(get(handles.Message_disp,'String'), ...
        'Successfully Trained!!!',handles.line_in_msgdisp,' ',...
        'Now, Start testing the image by going to "Testing" tab',' '));
        index = size(get(handles.Message_disp,'String'), 1);
        set(handles.Message_disp,'Value',index);
drawnow

% svm ended

set(handles.animation_svm,'Backgroundcolor','g');
drawnow


        
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



function testing_load_image_text_Callback(hObject, eventdata, handles)
% hObject    handle to testing_load_image_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of testing_load_image_text as text
%        str2double(get(hObject,'String')) returns contents of testing_load_image_text as a double


% --- Executes during object creation, after setting all properties.
function testing_load_image_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testing_load_image_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in testing_load_image_browse.
function testing_load_image_browse_Callback(hObject, eventdata, handles)
% hObject    handle to testing_load_image_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im im2
[path, user_cance] = imgetfile();
set(handles.testing_load_image_text,'String',path);
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
set(handles.image_edit_panel,'Visible','on');
im = imread(path);
save('path.mat','path');
im2=im;

adjust(handles);






% --- Executes on slider movement.
function slider_brightness_Callback(hObject, eventdata, handles)
% hObject    handle to slider_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

val = get(hObject,'Value');

set(handles.edit_brightness,'String',num2str(val));
adjust(handles);

function adjust(handles)

global im im2 im3
im=im2;
im3 = im;
a=0;
b=1;
c=0;
d=1;
val_b = get(handles.slider_brightness,'Value');
val_c = get(handles.slider_contrast,'Value');

if(val_b < 0)
    val_b = -1*val_b;
    d =d - val_b/100;
else
    c = c + val_b/100;
end

if(val_c < 0)
    val_c = -1*val_c;
    a =a + val_c/100;
else
    b = b - val_c/100;
end

%searchme
axes(handles.testing_load_image_show);
im = imadjust(im, [a b],[c d]);
im3 = im;
imshow(im);

% --- Executes during object creation, after setting all properties.
function slider_brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value',0);

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'Value');

set(handles.edit_contrast,'String',num2str(val));
adjust(handles);


% --- Executes during object creation, after setting all properties.
function slider_contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value',0);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

val = get(hObject,'String');
val = str2num(val);


function edit_brightness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_brightness as text
%        str2double(get(hObject,'String')) returns contents of edit_brightness as a double
val = get(hObject,'String');
val = str2num(val);
if(size(val,1)==0)
    msgbox(sprintf('Error'),'Error','Error');
    return
end
if(val>100)
    val =100;
end
if(val<-100)
    val = -100;
end
set(handles.slider_brightness,'Value',val);
adjust(handles);


% --- Executes during object creation, after setting all properties.
function edit_brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to edit_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_contrast as text
%        str2double(get(hObject,'String')) returns contents of edit_contrast as a double
val = get(hObject,'String');
val = str2num(val);
if(size(val,1)==0)
    msgbox(sprintf('Error'),'Error','Error');
    return
end
if(val>100)
    val =100;
end
if(val<-100)
    val = -100;
end
set(handles.slider_contrast,'Value',val);
adjust(handles);

% --- Executes during object creation, after setting all properties.
function edit_contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Detect_image.
function Detect_image_Callback(hObject, eventdata, handles)
% hObject    handle to Detect_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3 im

bounding_rect = localize(im);
load('trained_models');
histogram_temp = []; descp = [];
for i=1:length(bounding_rect)
    thisBB = bounding_rect(i).BoundingBox;
    test_image = imcrop(im3, [thisBB(1),thisBB(2),thisBB(3),thisBB(4)]);
if(size(test_image,3)>1)
    test_image = rgb2gray(test_image);
end
    imwrite(mat2gray(test_image),'temporary_crop.jpg');
    histogram = generate_bow('temporary_crop.jpg');
    histogram_temp = [histogram_temp; histogram];
    
    [a(1,1),a(2,1)] = svmPredict(trained_models{1}.model,histogram);
        [a(1,2),a(2,2)] = svmPredict(trained_models{2}.model,histogram);
        [a(1,3),a(2,3)] = svmPredict(trained_models{3}.model,histogram);
        
        [m, idx] = max(a,[],2);
        
        if(m(1,:) == 1 )
            disp_text = trained_models{idx(2,:)}.name;
            descp = [descp;idx(2,:)];
        else
            disp_text = 'Not identified!';
        end
        
    hold on;
        rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
            'EdgeColor','y','LineWidth',2);
        text(thisBB(1),thisBB(2)+thisBB(4)+9,disp_text,'FontSize',15 );
        
end

save('histogram_temp.mat','histogram_temp');
save('bounding_rect.mat','bounding_rect');
save('descp.mat','descp');


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1



function load_model_edit_Callback(hObject, eventdata, handles)
% hObject    handle to load_model_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_model_edit as text
%        str2double(get(hObject,'String')) returns contents of load_model_edit as a double


% --- Executes during object creation, after setting all properties.
function load_model_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_model_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_model_btn.
function load_model_btn_Callback(hObject, eventdata, handles)
% hObject    handle to load_model_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_path = fullfile(pwd,'trainedModels');
filename = uigetfile({'*.mat' },'mytitle',...
          file_path);
set(handles.load_model_edit,'String',filename);

% --- Executes on button press in Reinforce.
function Reinforce_Callback(hObject, eventdata, handles)
% hObject    handle to Reinforce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Reinforcement;

% --- Executes on button press in correct_btn.
function correct_btn_Callback(hObject, eventdata, handles)
% hObject    handle to correct_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function Message_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Message_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Set global variables
line_in_msgdisp = '----------------------------------------------------------------------------------------------';
handles.line_in_msgdisp = line_in_msgdisp;
guidata(hObject,handles);


set(hObject,'String',strvcat('Object Detection',handles.line_in_msgdisp));
index = size(get(hObject,'String'), 1);
set(hObject,'Value',index);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes during object creation, after setting all properties.
function load_images_browse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_images_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Test_play.
function Test_play_Callback(hObject, eventdata, handles)
% hObject    handle to Test_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global play_icon_off play_icon im bounding_rect im3
button_state = get(hObject,'Value');
% axes(handles.testing_load_image_show);
% imshow(im);
if button_state == get(hObject,'Max')
    set(handles.Test_play,'cdata',play_icon_off);
	% localize;
    im3 = im;
    bounding_rect = localize(im);
    for k = 1 : length(bounding_rect)
  thisBB = bounding_rect(k).BoundingBox;
   if(thisBB(3)<40)
       continue;
   end
   hold on
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','y','LineWidth',2 )
    end

elseif button_state == get(hObject,'Min')
    set(handles.Test_play,'cdata',play_icon);
    axes(handles.testing_load_image_show);

    imshow(im3);
	%
end

% --- Executes on key press with focus on edit_brightness and none of its controls.
function edit_brightness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_brightness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
