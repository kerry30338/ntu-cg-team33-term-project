# ntu-cg-team33-term-project

2024 Computer Graphics term project, group 33.

## Introduction

In this term project, we write a Minecraft shader which enhances the appearance of vanilla Minecraft.
To enhance its graphics, we implements hand-held lighting and colored shadow in this shaderpack.
To learn more about what we have implemented, please check out the **Feature** section.
Lastly, this shaderpack is written in GLSL and we use the Optifine mod to render the shader, so you should install Optifine to use this shaderpack.

## Usage  

0. You must have a Minecraft account and Java edition launcher. :)
1. [Download](https://www.optifine.net/downloads), install and create a OptiFine "installation" of Minecraft launcher. (Please Google "OptiFine installation" in your language, you'll see lots of tutorials on the Web.)  
PS.: The shaderpack is develop under the environment of Java edition 1.12.2 (OptiFine HD U G5), higher edition coompatibility is not fully test.  
2. ZIP the whole "shaders" folder as a ZIP file, name it as you want, and move it into ```%appdata%/.minecraft/shaderpacks/```
3. Start playing Minecraft with the OptiFine installation, and set the "Option/Video Setting/Shaders" to the "(what you named).zip".
> P.S. Step 1. ~ 3. is for those who don't play Minecraft with shaderpacks a lot. If you are experienced with shaders in OptiFine, you can just see the ```shaders``` folder as a not-yet-compressed shaderpack.  
4. Explore what we've done in beautifying the lighting in Minecraft's world. :)  

## Features  

周民恩
* Hand-held lighting ("Light Fairy"):  
When player holds a lighting cube in either of hands, camera becomes an additional light source to illuminate the blocks around.  

張凱瑞
* Shadow:  
When an entity or a block is illuminated by the sun or the moon, a shadow is created on the ground. In addition, If the entity or block is transparent, a colored shadow is created.
* Tonemapping:  
We use the Uncharted 2 tonemap method to tonemap the HDR frame.
