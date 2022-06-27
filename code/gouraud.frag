#version 150

// Use this as the basis for each of your fragment shaders.
// Be sure to replace "SHADER" with the specific shader type
// and "YOUR_NAME_HERE" with your own name.

//
// Gouraud fragment shader
//
// @author  RIT CS Department
// @author  Nicholas Shinn
//

///////////////////////////////////////////////////////
// Add any incoming variables (from the application
// or from the vertex shader) here
///////////////////////////////////////////////////////

//Color calculated by the vertex shader
in vec4 color;

// Outgoing fragment color
out vec4 fragColor;

void main()
{
    ///////////////////////////////////////////////////////
    // Add all illumination and shading code you need here
    ///////////////////////////////////////////////////////
    
    //Sets the fragment color to the color calculated by the vertex shader
    fragColor = color;
}
