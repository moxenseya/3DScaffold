%%
%Change the value of the UB variable only. It controls the upper bound,
%lower bound, and the X and Y dimnesions of the areas matrix. Since all the
%values are symmetric around 0, the program calculates the dimesions
%automatically.

UB=25;

LB=-UB;
DIM = (UB*2)+1;

disp (['Dimensions of the array are: ', int2str(DIM) , ' x ' , int2str(DIM)]);
disp(['The bounds for the rotations are: ', int2str(LB) , ' to ' , int2str(UB)]);

tic
areavalue=zeros(DIM,DIM);
Xvalues = zeros(size(areavalue));
Yvalues = zeros(size(areavalue));
for rotX = LB:1:UB
   for rotY = LB:1:UB
      areavalue((rotX+UB+1),(rotY+UB+1))= OptimizeArea_Verification([rotX,rotY,1]);
      Xvalues((rotX+UB+1),(rotY+UB+1))= rotY;
      Yvalues((rotX+UB+1),(rotY+UB+1))= rotY;
      disp(['iteration ', num2str(rotX+UB+1), ' ', num2str(rotY+UB+1)]);
   end
end    
toc

%%
%Experimental Section : Plotting values on Surf for 3D Plot


figure, surf(Xvalues,Yvalues',areavalue)

