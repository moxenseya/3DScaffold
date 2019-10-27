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

## Team

|                <a href="https://github.com/moxenseya" target="_blank">**Abrar Hussain Syed**</a>                |       <a href="https://www.linkedin.com/in/abaghaie/" target="_blank">**Ahmadreza Baghaie**</a>       |         <a href="https://www.researchgate.net/profile/Azhar_Ilyas" target="_blank">**Azhar Ilyas**</a>          |
| :----------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------: |
| [![Abrar Hussain Syed](https://moxenseya.me/img/Face1.jpg)](https://github.com/moxenseya) |                  [![Abaghaie](https://media.licdn.com/dms/image/C4E03AQHTlW3tNj-m5Q/profile-displayphoto-shrink_800_800/0?e=1577923200&v=beta&t=Eal41oAW0KUdQmtzJraA1-x4Z8b__uCmMsUhVzlxtA4)```
<!-- .element height="50%" width="50%" -->
``` ](https://github.com/gint0kix)                  |                    [![Kim](LINK)](https://github.com/Gold-Turtle)                     |
|           <a href="https://github.com/moxenseya" target="_blank">`https://www.github.com/moxenseya`</a>            | <a href="https://www.linkedin.com/in/abaghaie/" target="_blank">`https://www.linkedin.com/in/abaghaie/`</a> | <a href="https://github.com/Gold-Turtle" target="_blank">`github.com/Gold-Turtle`</a> |
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5NjI2NTIzMTEsLTE3OTU3NjIzNTEsLT
E0Nzg2MzIxNzcsLTI5OTU5OCwxNjE3NDM2ODQ4XX0=
-->