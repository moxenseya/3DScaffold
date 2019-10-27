# Automated Image Processing Based 3D Printed Scaffolds for Critical Size Bone Fracture Treatment
### Introduction
Bone tissues in critical-size bone fractures, do not regenerate naturally and require special treatments, for example by using scaffold implants that can facilitate the process of healing. In this work we propose a new technique for automatic segmentation of bone fractures to facilitate the process of manufacturing the patient-specific scaffolds. To achieve this, after pre-processing the acquired 3D Computed Tomography (CT) images, we use thresholding segmentation to extract the bone from the scan. This step is followed by orientation optimization of the segmentation result by taking advantage of a global optimization technique, namely Simulated Annealing, to ensure maximized visibility of the fracture in a projected view. Binary hole-filling techniques and bone thickness estimation is then used to create a 3D template to be sent for scaffold printing. Experiments with both synthetic and real datasets show that the proposed method is an effective approach for creating rapid, precise and patient-specific 3D scaffolds to treat critical-size bone fractures.  
### Requirements
This program requires MATLAB and the Global Optimization Toolbox.

### Usage

This program can be run two ways a fully automated script, or using the provided GUI app.

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5ODY4OTU0ODUsMTYxNzQzNjg0OF19
-->