#version 150

// Use this as the basis for each of your vertex shaders.
// Be sure to replace "SHADER" with the specific shader type
// and "YOUR_NAME_HERE" with your own name.

//
// Phong vertex shader
//
// @author  RIT CS Department
// @author  Nicholas Shinn
//

//
// Vertex attributes
//

// Vertex location (in model space)
in vec4 vPosition;

// Normal vector at vertex (in model space)
in vec3 vNormal;

//
// Uniform data
//

// Transformations
uniform mat4 viewMat;  // view (camera)
uniform mat4 projMat;  // projection

// Model transformation matrices
uniform mat4 modelMat; // composite

//////////////////////////////////////////////////////
// Add any additional incoming variables you need here
//////////////////////////////////////////////////////

//Light position to transform to view space
uniform vec4 l_pos;

//////////////////////////////////////////////////////
// Add any outgoing variables you need here
//////////////////////////////////////////////////////

//Transformed positions to be sent to fragment shader
out vec4 position;
out vec4 normal;
out vec4 light_position;

void main()
{
    // create the modelview matrix
    mat4 modelViewMat = viewMat * modelMat;

    //////////////////////////////////////////////////////
    // Add all illumination and shading code you need here
    //////////////////////////////////////////////////////

    //Creates the normal transform matrix from the inverse transpose of the upper 3x3 submatrix from the model view matrix
    mat3 nTransform = transpose(inverse(mat3(modelViewMat)));

    //Transforms the position vectors by their respective transformation matrices
    position = modelViewMat * vPosition;
    normal = vec4((nTransform * vNormal), 0.0);
    light_position = viewMat * l_pos;

    // send the vertex position into clip space
    gl_Position =  projMat * modelViewMat * vPosition;
}
