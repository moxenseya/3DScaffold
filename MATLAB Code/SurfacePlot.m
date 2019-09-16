%%
%Change the values of areavalue and the for loop constraints to make the
%size change for the arrays.
tic
areavalue=zeros(41,41);
Xvalues = zeros(size(areavalue,1),size(areavalue,2));
Yvalues = zeros(size(areavalue,1),size(areavalue,2));
for rotX = -20:1:20
   for rotY = -20:1:20
      areavalue(rotX+21,rotY+21)= OptimizeArea_Verification([rotX,rotY,1]);
      Xvalues(rotX+21,rotY+21)= rotY;
      Yvalues(rotX+21,rotY+21)= rotY;
      disp(['iteration ', num2str(rotX+21), ' ', num2str(rotY+21)]);
   end
end    
toc

%%
%Experimental Section : Plotting values on Surf for 3D Plot


figure, surf(Xvalues,Yvalues',areavalue)

