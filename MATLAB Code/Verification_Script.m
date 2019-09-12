%Code for verifying the outputs from optimizers

%Step 1: Create a volume and initialize it to zeros

%%
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
diskImg=diskImg(1:2:end,1:2:end,1);

global final_hole_volume
final_hole_volume=zeros(size(diskImg,1), size(diskImg, 2), round(ceil(150)));

%Step 2: Repeatedly copy and put the image into this volume with imfills

%%
for i=50:round(100)
    %final_hole_volume(:,:,i)=imfill(diskImg,'holes');
    final_hole_volume(:,:,i)=diskImg;
end

%Step 3: For an example, see the figure at end points and middle

%%
imshow(final_hole_volume(:,:,100))




%Step 4: Apply a rotation to the volume
%%
ROTATION_Y=-20;

global final_hole_volume_rotated

final_hole_volume_rotated = double(imrotate3(final_hole_volume,int8(ROTATION_Y),[0 1 0],'loose'));
imshow(final_hole_volume_rotated(:,:,75))

%%
%Test Section : Checking to see if we have a proper fill and hole
%extraction

sum_projection=mean(final_hole_volume_rotated,3); 
binary_sum_projection = sum_projection > 0;
filled_sum_projection = imfill(sum_projection>0,'holes'); 

difference = filled_sum_projection-binary_sum_projection;


figure,
subplot(221), imshow(sum_projection,[]);title('Rotated Volume');
subplot(222), imshow(difference,[]);title('Extracted shape');
subplot(223), imshow(mean(final_hole_volume,3),[]);title('Original Volume');


%%
%Experimental Section : Creating a surface plot of the rotation and area
%values in 3D.

%Change the values of areavalue and the for loop constraints to make the
%size change for the arrays.
tic
areavalue=zeros(21,21);
Xvalues = zeros(size(areavalue,1),size(areavalue,2));
Yvalues = zeros(size(areavalue,1),size(areavalue,2));
for rotX = -10:1:10
   for rotY = -10:1:10
      areavalue(rotX+11,rotY+11)= OptimizeArea_Verification([rotX,rotY,1]);
      Xvalues(rotX+11,rotY+11)= rotY;
      Yvalues(rotX+11,rotY+11)= rotY;
      disp(['iteration ', num2str(rotX+11), ' ', num2str(rotY+11)]);
   end
end    
toc

%%
%Experimental Section : Plotting values on Surf for 3D Plot


surf(Xvalues,Yvalues,areavalue)


%Step 5: Apply Optimization to restore rotation 
%%
    optionsSA=optimoptions('simulannealbnd','MaxIterations', 10,'PlotFcns',...
        {@saplotbestx,@saplotbestf,@saplotx,@saplotf});

    
    [rotationresult,functionvalue] =simulannealbnd(@OptimizeArea_Verification,(10*rand(1,1)),(ROTATION_Y-10),(ROTATION_Y+10),optionsSA);

    optionsSO=optimoptions('surrogateopt','PlotFcns',...
        {@saplotbestx,@saplotbestf,@saplotx,@saplotf});
    
  [rotationresultSO, functionvalueSO] =  surrogateopt(@OptimizeArea_Verification,(ROTATION_Y-10),(ROTATION_Y+10));    

      
  optionsPSW=optimoptions('particleswarm','MaxIterations', 10,'Display','iter','PlotFcn','pswplotbestf');
    
  [rotationresultPSW, functionvaluePSW] =  particleswarm(@OptimizeArea_Verification,2,(ROTATION_Y-10),(ROTATION_Y+10));    

    
%Optimizers below this comment need to be fixed    
optionsPS=optimoptions('patternsearch','MaxIterations', 10,'PlotFcns',...
        {@saplotbestx,@saplotbestf,@saplotx,@saplotf});
    
  [rotationresultPS, functionvaluePS] =  patternsearch(@OptimizeArea_Verification,(10*rand(1,1)),(ROTATION_Y-10),(ROTATION_Y+10),optionsPS);    
    

 
    