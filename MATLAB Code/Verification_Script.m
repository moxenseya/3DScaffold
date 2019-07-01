%Code for verifying the outputs from optimizers

%Step 1: Create a volume and initialize it to zeros


Input_directory_path = uigetdir(pwd,'Select folder Verification Disk');
Input_directory = dir(strcat(Input_directory_path, '\Disk_Verification.TIF'));

disp (['Selected directory is: ', Input_directory_path]);


%%% Initialize the array using zeros based on the size of the images.

%%% Find a way to put the values below in th program dynamically.(todo)
if(isempty(Input_directory))
    uialert(app.ScaffoldUIFigure,'No TIFF Images Found in specified folder','Error');
    return;
end


FileName=Input_directory(1).name;
temp2 =imread(strcat(relativepath(Input_directory_path), FileName));
disp (FileName)
diskImg =imread(strcat(relativepath(Input_directory_path), FileName));
diskImg=diskImg(:,:,1);

global final_hole_volume
final_hole_volume=zeros(size(diskImg,1), size(diskImg, 2), round(ceil(50)));

%Step 2: Repeatedly copy and put the image into this volume with imfills
for i=1:round(50)
    %final_hole_volume(:,:,i)=imfill(diskImg,'holes');
    final_hole_volume(:,:,i)=diskImg;
end

%Step 3: For an example, see the figure at end points and middle
imshow(final_hole_volume(:,:,50))




%Step 4: Apply a rotation to the volume

ROTATION_Y=3;


final_hole_volume_rotated = double(imrotate3(final_hole_volume,int8(ROTATION_Y),[0 1 0]));
imshow(final_hole_volume_rotated(:,:,50))


%Step 5: Apply Optimization to restore rotation 

    options=optimoptions('simulannealbnd','MaxIterations', 100,'PlotFcns',...
        {@saplotbestx,@saplotbestf,@saplotx,@saplotf});

    
    [rotationresult,functionvalue] =simulannealbnd(@OptimizeArea_Verification,(10*rand(1,1)),-10,10,options);

    