# Automated Image Processing Based 3D Printed Scaffolds for Critical Size Bone Fracture Treatment

### Introduction
Bone tissues in critical-size bone fractures, do not regenerate naturally and require special treatments, for example by using scaffold implants that can facilitate the process of healing. In this work we propose a new technique for automatic segmentation of bone fractures to facilitate the process of manufacturing the patient-specific scaffolds. To achieve this, after pre-processing the acquired 3D Computed Tomography (CT) images, we use thresholding segmentation to extract the bone from the scan. This step is followed by orientation optimization of the segmentation result by taking advantage of a global optimization technique, namely Simulated Annealing, to ensure maximized visibility of the fracture in a projected view. Binary hole-filling techniques and bone thickness estimation is then used to create a 3D template to be sent for scaffold printing. Experiments with both synthetic and real datasets show that the proposed method is an effective approach for creating rapid, precise and patient-specific 3D scaffolds to treat critical-size bone fractures.  
![Bone Scaffold](https://i.imgur.com/2RhLnXO.jpg)

![Workflow for the approach](https://i.imgur.com/AWQE0vJ.png)

### Requirements
This program was created using MATLAB 2018a and the Global Optimization Toolbox. Please make sure you have the same version or higher installed on your machine.

### Usage

This program can be run two ways:
- Fully automated script. - **ProjectionScript.m**
- Using the provided GUI app. - **ProjectionApplication.mlapp**
- 
### Documentation

The original technical paper for this work will be available soon.

## Research Team

|                <a href="https://github.com/moxenseya" target="_blank">**Abrar Hussain Syed**</a>                |       <a href="https://www.linkedin.com/in/abaghaie/" target="_blank">**Dr. Ahmadreza Baghaie**</a>       |         <a href="https://www.researchgate.net/profile/Azhar_Ilyas" target="_blank">**Dr. Azhar Ilyas**</a>          |
| :----------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------: |
| ![Moxenseya](https://moxenseya.me/img/Face1.jpg) |                  ![Abaghaie](https://i.imgur.com/bEVInJn.jpg)|                    ![Ailyas](https://i.imgur.com/GgbcSGE.jpg) 
            
<!--stackedit_data:
eyJoaXN0b3J5IjpbODM1MzI3MDg5LC0xNzk1NzYyMzUxLC0xND
c4NjMyMTc3LC0yOTk1OTgsMTYxNzQzNjg0OF19
-->