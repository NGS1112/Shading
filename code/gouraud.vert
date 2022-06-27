#version 150

// Use this as the basis for each of your vertex shaders.
// Be sure to replace "SHADER" with the specific shader type
// and "YOUR_NAME_HERE" with your own name.

//
// Gouraud vertex shader
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

//Original light position and color vectors
uniform vec4 l_col;
uniform vec4 l_pos;
uniform vec4 a_col;

//Material properties of the current shape
uniform vec4 mat_a_col;
uniform float mat_ka;
uniform vec4 mat_d_col;
uniform float mat_kd;
uniform vec4 mat_s_col;
uniform float mat_s_exp;
uniform float mat_ks;


//////////////////////////////////////////////////////
// Add any outgoing variables you need here
//////////////////////////////////////////////////////

//Color to be applied by fragment shader
out vec4 color;

void main()
{
    // create the modelview matrix
    mat4 modelViewMat = viewMat * modelMat;

    //////////////////////////////////////////////////////
    // Add all illumination and shading code you need here
    //////////////////////////////////////////////////////

    //Creates the normal transform matrix by taking the inverse transpose of the top 3x3 submatrix from the model view matrix
    mat3 nTransform = transpose(inverse(mat3(modelViewMat)));

    //Calculates the position, normal, and light position in clip space from their respective matrices
    vec4 position = modelViewMat * vPosition;
    vec4 normal = vec4((nTransform * vNormal), 0.0);
    vec4 light_position = viewMat * l_pos;

    //Calculates the light vector by taking the normalized difference between light position and vertex position
    vec4 light_direction = normalize(light_position - position);

    //Calculates normal vector by simply normalizing it
    normal = normalize( normal );

    //Calculates cos theta by taking the dot product of normal and light vectors, uses max to ensure no negative values
    float dif = max( dot( normal, light_direction ), 0.0 );

    //Calculates the reflection vector by reflecting the negative light vector over the normal vector
    vec4 reflect_direction = normalize( reflect( -light_direction, normal ) );

    //Calculates the view vector by simply normalizing the negative vertex position
    vec4 view_direction = normalize( -position );

    //Calculates cos alpha by taking the dot product of the reflect and view vectors, uses max to ensure no negative values
    float dif2 = max( dot( reflect_direction, view_direction ), 0.0 );

    //Calculates the color using phong illumination and sends it to fragment shader
    color = a_col*mat_ka*mat_a_col + l_col*mat_kd*mat_d_col*dif + l_col*mat_ks*mat_s_col*pow(dif2, mat_s_exp);

    // send the vertex position into clip space
    gl_Position =  projMat * modelViewMat * vPosition;
}
