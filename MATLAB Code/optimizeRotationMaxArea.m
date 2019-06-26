function optimarea = optimizeRotationMaxArea(AxisandRot)

            global FILTERED_IMAGE_ARRAY;
          %  global fig;

%global BoneProjection;
%global HoleProjection;

imgDataDBROT1 = double(imrotate3(FILTERED_IMAGE_ARRAY,int8(AxisandRot(1)),[0 1 0]));
            imgDataDBROT3 = double(imrotate3(imgDataDBROT1 ,int8(AxisandRot(2)),[1 0 0]));
%imgDataDBROT3 = double(imrotate3(imgDataDBROT2 ,int8(AxisandRot(3)),[1 0 0],'crop'));


sum_projection=mean(imgDataDBROT3,3); 
binary_sum_projection = sum_projection > 0;
filled_sum_projection = imfill(sum_projection>0,'holes'); 

difference = filled_sum_projection-binary_sum_projection;

%set(BoneProjection,'CData',image(sum_projection));
%set(HoleProjection,'CData',image(difference));

% fig,
% subplot(221), imshow(sum_projection,[]);title('Before Rotation');
% subplot(222), imshow(difference,[]);title('After Rotation');



area = sum(difference(:));
optimarea = -area;
end