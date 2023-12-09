function varargout = snake_20(varargin)
% SNAKE_20 MATLAB code for snake_20.fig
%      SNAKE_20, by itself, creates a new SNAKE_20 or raises the existing
%      singleton*.
%
%      H = SNAKE_20 returns the handle to a new SNAKE_20 or the handle to
%      the existing singleton*.
%
%      SNAKE_20('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SNAKE_20.M with the given input arguments.
%
%      SNAKE_20('Property','Value',...) creates a new SNAKE_20 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before snake_20_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to snake_20_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help snake_20

% Last Modified by GUIDE v2.5 22-Oct-2023 03:17:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @snake_20_OpeningFcn, ...
                   'gui_OutputFcn',  @snake_20_OutputFcn, ...
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


% --- Executes just before snake_20 is made visible.
function snake_20_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to snake_20 (see VARARGIN)

% Choose default command line output for snake_20
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes snake_20 wait for user response (see UIRESUME)
% uiwait(handles.snake);
axes(handles.axes1);
axis('off');

% Start the game by calling push_button6_Callback
push_button6_Callback(hObject, eventdata, handles);

% --- Outputs from this function are returned to the command line.
function varargout = snake_20_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PAUSE.
function PAUSE_Callback(hObject, eventdata, handles)
% hObject    handle to PAUSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global move_status;
move_status=0;

% --- Executes on button press in RIGHT.
function RIGHT_Callback(hObject, eventdata, handles)
% hObject    handle to RIGHT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global direction move_status;
if ~(direction==3)
    direction=1;
    move_status=1;
end

% --- Executes on button press in DOWN.
function DOWN_Callback(hObject, eventdata, handles)
% hObject    handle to DOWN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global direction move_status;
if ~(direction==2)
    direction=4;
    move_status=1;
end

% --- Executes on button press in LEFT.
function LEFT_Callback(hObject, eventdata, handles)
% hObject    handle to LEFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global direction move_status;
if ~(direction==1)
    direction=3;
    move_status=1;
end

% --- Executes on button press in UP.
function UP_Callback(hObject, eventdata, handles)
% hObject    handle to UP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global direction move_status;
if ~(direction==4)
    direction=2;
    move_status=1;
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_r mat_g mat_b;
global direction; direction=2;
global points;points=0;
global move_status; move_status=0;
t=0.1;
locx=[50 50 50 50 50 50 50 50 50];
locy=[60 61 62 63 64 65 66 67 68];

mat_r=zeros(100,100);
mat_g=zeros(100,100);
mat_b=zeros(100,100);
update_snake(locx,locy);

while(1)
    pt_x=randperm(size(mat_r,1),1);
    pt_y=randperm(size(mat_r,1),1);
    if sum(locx==pt_x & locy==pt_y)==0
        break;
    end
end
mat_r(pt_x,pt_y)=255;
mat_g(pt_x,pt_y)=255;
mat_b(pt_x,pt_y)=255;


imshow(uint8(cat(3,mat_r,mat_g,mat_b)));
while(1)
    imshow(uint8(cat(3,mat_r,mat_g,mat_b)));
    pause(t);
    if(move_status)
        len=length(locx);
        for i=1:len
            mat_r(locx(i),locy(i))=0;
            mat_g(locx(i),locy(i))=0;
            mat_b(locx(i),locy(i))=0;
        end
        if sum((locx(1)==pt_x) & (locy(1)==pt_y))==1
            locx(2:len+1)=locx(1:len);
            locy(2:len+1)=locy(1:len);
            while(1)
                pt_x=randperm(size(mat_r,1),1);
                pt_y=randperm(size(mat_r,1),1);
                if sum(locx==pt_x & locy==pt_y)==0
                    break;
                end
            end
            mat_r(pt_x,pt_y)=255;
            mat_g(pt_x,pt_y)=255;
            mat_b(pt_x,pt_y)=255;
            points=points+1;
            set(handles.text3,'String',num2str(points));
        else
            locx(2:len)=locx(1:len-1);
            locy(2:len)=locy(1:len-1);
        end
         if direction==1
             if locy(1)==100
                 locy(1)=1;
             else
                 locy(1)=locy(1)+1;
             end
         elseif direction==2
             if locx(1)==1
                 locx(1)=100;
             else 
                 locx(1)=locx(1)-1;
             end
         elseif direction==3
             if locy(1)==1
                 locy(1)=100;
             else
                 locy(1)=locy(1)-1;
             end
         elseif direction==4
             if locx(1)==100
                 locx(1)=1;
             else
                 locx(1)=locx(1)+1;
             end
         end
         if sum((locx(2:end)==locx(1)) & (locy(2:end)==locy(1)))
             mat_r(:,:)=255;
             mat_g(:,:)=0;
             mat_b(:,:)=0;
             imshow(uint8(cat(3,mat_r,mat_g,mat_b)));
             msgbox('Game over..!');
             break;
         end
         update_snake(locx,locy);
         if points==5
             t=0.08;
         elseif points==10
             t=0.05;
         elseif points==15
             t=0.03;
         elseif points==30
             t=0.01;
         elseif points==50
             t=0.008;
         end
    end
end
    

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close; 


function update_snake(locx,locy)
global mat_r mat_g mat_b
    mat_r(locx(1),locy(1))=255;
    mat_g(locx(1),locy(1))=0;
    mat_b(locx(1),locy(1))=0;

    for i=2:length(locx)
        mat_r(locx(i),locy(i))=0;
        mat_g(locx(i),locy(i))=255;
        mat_b(locy(i),locy(i))=0;
    end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on key press with focus on snake and none of its controls.
function snake_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to snake (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%   Key: name of the key that was pressed, in lower case
%   Character: character interpretation of the key(s) that was pressed
%   Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global direction move_status;
switch(eventdata.Key)
    case 'uparrow'
        if ~(direction==4)
            direction=2;
            move_status=1;
        end
    case 'downarrow'
        if ~(direction==2)
            direction=4;
            move_status=1;
        end
    case 'rightarrow'
        if ~(direction==3)
            direction=1;
            move_status=1;
        end
    case 'leftarrow'
        if ~(direction==1)
            direction=3;
            move_status=1;
        end
    case 'return'
        move_status=0;
    otherwise
        direction=direction;
        move_status=1;
end
% Update the score here
set(handles.text3, 'String', num2str(points));

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function snake_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to snake (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function snake_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to snake (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function snake_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to snake (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
