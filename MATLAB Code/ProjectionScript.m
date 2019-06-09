%%% This script uses CT Scan Images and creates an STL volume based on the
%%% projection of the fracture hole detected in the volume. 


%%% Step 0: Clearing the Console and the workspace

clc 
clear all
close all

disp('Program Started!');
if(exist('STL_Outputs\','dir'))
    disp('WARNING: Output folder exists. New outputs will overwrite old data!');
else
    disp('No output folder found, creating folder now... ');
    mkdir('STL_Outputs');
    disp('Output folder created!');
end
    
%%% Step 1: Load all the input files from the directory into the program
%%% using a for loop. Ensure that this script resides one folder above the
%%% directory in which your CT scan image slices are stored
Input_directory_path = uigetdir(pwd,'Select folder containing CT-Scan Slices');
Input_directory = dir(strcat(Input_directory_path, '\*.TIF'));
disp (['Selected directory is: ', Input_directory_path]);

disp(['Input Directory has ', num2str(length(Input_directory)), ' Slices']);

%%% Initialize the array using zeros based on the size of the images.
%%% Find a way to put the values below in th program dynamically.(todo)

image_array = zeros(1024,1024,length(Input_directory));

disp('Creating slices volume... ');

for i=1:length(Input_directory)
  FileNames=Input_directory(i).name;
   temp=imread(strcat(relativepath(Input_directory_path), FileNames));
   %%%Dynamic name in strcat function above(todo)
   temp=temp(:,:,1);
   image_array(:,:,i)=temp;
end

disp('Slices volume created successfully!');

%%% Reducing the resolution of the volume to simplify calculations

prompt = {'Please specify downscaling factor of volume (+ve Integer). Enter 1 if full resolution needed: '};
dlgtitle = 'Input';
dims = [1 55];
downscaling_factor = inputdlg(prompt,dlgtitle,dims);

image_array_downsized =image_array(1:str2double(downscaling_factor):end, 1:str2double(downscaling_factor):end, 1:str2double(downscaling_factor):end);

disp(['Slices downscaled 1/',num2str(str2double(downscaling_factor)),' successfully!']);

%%% Also provide user a way to specify how much downsizing to do. Disp it as well (todo)

%%% Step 2: Preprocessing the images

%%% Remove Noise (todo)
%%% Bilateral Filtering? (todo)
%%% Fill Holes (todo)
%%% Applying binary thresholding
disp('Applying Binary Thresholding... ');

level = 255*graythresh(image_array_downsized(:)./255);

image_array_downsized_binarized= double(imbinarize(image_array_downsized,level));

%%% Finding largest connected components and storing it in the array
disp('Finding Lagest Connected Component... ');

Connected_Components = bwconncomp(image_array_downsized_binarized);
largestCompIndex = 0;
tempLen=0;

for i =1:Connected_Components.NumObjects
    temp = length(Connected_Components.PixelIdxList{1,i});
    if temp >tempLen
        tempLen = temp;
        largestCompIndex = i;
    end
end

%%% Using the connected component indices, make the pixels in that much
%%% selection as 1. This will filter out all the disconnected pixels

%%% Display Maximum connected component details (todo)
global image_array_downsized_binarized_masked
image_array_downsized_binarized_masked = zeros(size(image_array_downsized_binarized));
image_array_downsized_binarized_masked (Connected_Components.PixelIdxList{1,largestCompIndex}) = 1;

disp('Bone volume pre-processed successfully!');
%%% We saved the above array here in previous script, make it work without it(todo)


%%% Step 3: Obtaining the optimal projections

%%% We use projections to detect the bone region. The projection that
%%% provides us maximum region of bone area is the optimal projection. We
%%% apply function optimizer to obtain best angles of rotation for best
%%% view of the hole.

%%% We apply simulated annealing in this case, as it works fast and has
%%% sufficient stopping criteria. 

%%% Need to find best stopping criteria for the algorithm. Don't hesitate to try a different optimizer as well, as long as it provides a best fitting value for the objective function (todo)

disp('Starting rotation optimization for finding maximum area of fracture... ');

options=optimoptions('simulannealbnd','MaxIterations', 10,'PlotFcns',...
          {@saplotbestx,@saplotbestf,@saplotx,@saplotf});
[rotationresult,functionvalue] =simulannealbnd(@optimizeRotationMaxArea,[0 0 0],-10,10, options);
close all
disp(['Optimization completed successfully! The optimal angles are (ZYX): ',num2str(rotationresult), ' with an area of ', num2str(abs(functionvalue)) , ' units']);
%%% Plug in the rotationresult values into the rotation values below (todo)

disp('Rotating the bone volume to optimal projection angle...');

imgDataDBROT1 = double(imrotate3(image_array_downsized_binarized_masked,int8(rotationresult(1)),[0 0 1])); 
imgDataDBROT2 = double(imrotate3(imgDataDBROT1 ,int8(rotationresult(2)),[0 1 0]));
imgDataDBROT3 = double(imrotate3(imgDataDBROT2 ,int8(rotationresult(3)),[1 0 0]));

disp('Rotation completed!');

% figure('Name','Preview of Bone Volume','NumberTitle','off'),
% subplot(221), imshow(mean(image_array_downsized,3),[]);title('Before Rotation');
% subplot(222), imshow(mean(imgDataDBROT3,3),[]);title('After Rotation');


%%% FOR DEMONSTRATION ONLY!!! USE ONLY FOR 3-D PRINTING BONE VOLUMES FOR DEMO!!! (fixme)
prompt = {'Please specify whether you want to create bone volume as STL on disk:'};
dlgtitle = 'Write bone volume as STL to Disk? Enter Y or y if yes';
dims = [1 55];
useranswer = inputdlg(prompt,dlgtitle,dims)

if(string(useranswer) == 'Y' || string(useranswer) == 'y')
    disp('Writing bone volume to disk... ');
    ind = find(imgDataDBROT3);
    [x, y, z] = ind2sub(size(imgDataDBROT3), ind);
    P = [x y z];
    shp = alphaShape(P);
    [bf,P] = boundaryFacets(shp);

    stlwrite('STL_Outputs\bone_volume.stl',bf,P);

    disp('Bone volume STL file written to disk! Find it in STL_Outputs Folder!');
else
    disp('User skipped bone STL creation');
end

%%% Now we have the volume in optimal rotation angle. We can now obtain the
%%% projections of the volume


%%% Step 4: Creating the hole projection

disp('Creating the hole projection...');

%%% Consider below variable as 'A'
sum_projection=mean(imgDataDBROT3,3); 

%%% Note: we create binarized version of sum_projection for hole
%%% calculation, and the original sum version is used for thickness
%%% estimation.
binary_sum_projection = (sum_projection>0);

%%% Consider below variable as 'B'
filled_sum_projection = imfill(binary_sum_projection,'holes');


%%% B is a superset of A, which contains A as well as pixels of the hole
%%% region. Now we can obtain the hole region pixels by subtraction (B-A)

binary_hole_projection =abs(filled_sum_projection-binary_sum_projection);

%%% This projection is the final shape of the hole that we can use to
%%% create the final volume for printing. Now we need to replicate this
%%% shape for <thickness> times along Z-Axis to obtain required depth.


%%% Step 5: Calculating Thickness of the volume

%%% Thickness of the bone can be considered as the sum of all the voxels
%%% along the depth of the bone, when each voxel is a unit value of 1.


%%% Put the notes here (todo) 
struct_elem1 = strel('square',5);
binary_hole_eroded=imopen(binary_hole_projection, struct_elem1);

struct_elem2 = strel('square', 31);
binary_hole_dilated = imdilate(binary_hole_eroded,struct_elem2, 'same');

binIntersection = binary_hole_dilated&binary_sum_projection;

automatic_thickness_estimate= round(100* mean(nonzeros(double(binIntersection).*sum_projection)));

prompt = {'Please verify thickness of scaffold. Below value is automatically calculated : '};
dlgtitle = 'Input';
dims = [1 55];
definput = {num2str(automatic_thickness_estimate)};
final_thickness = inputdlg(prompt,dlgtitle,dims,definput);

final_hole_volume=zeros(size(imgDataDBROT3,1), size(imgDataDBROT3, 2), round(ceil(str2double(final_thickness))));

for i=1:round(str2double(final_thickness))
    final_hole_volume(:,:,i)=imfill(binary_hole_eroded,'holes');
end

disp('Scaffold volume created!');

disp('Creating isosurface of scaffold... ');

isosurface_of_hole_volume = isosurface(final_hole_volume,.5);
%patchVolume = patch(isosurf);
%patchFilled = convhulln(isosurf)

%%% Test if patch conversion is needed or not (todo)
disp('Isosurface created successfully!');

disp('Writing scaffold volume to disk... ');

stlwrite('STL_Outputs\scaffold_volume.stl',isosurface_of_hole_volume);

disp('Scaffold STL written to disk! Find it in STL_Outputs Folder!');
winopen('STL_Outputs\');
disp('Program finished successfully!');