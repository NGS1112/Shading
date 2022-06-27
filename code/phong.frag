#version 150

// Use this as the basis for each of your fragment shaders.
// Be sure to replace "SHADER" with the specific shader type
// and "YOUR_NAME_HERE" with your own name.

//
// Phong fragment shader
//
// @author  RIT CS Department
// @author  Nicholas Shinn
//

///////////////////////////////////////////////////////
// Add any incoming variables (from the application
// or from the vertex shader) here
///////////////////////////////////////////////////////
in vec4 position;
in vec4 normal;
in vec4 light_position;

uniform vec4 l_col;

uniform vec4 a_col;

uniform vec4 mat_a_col;
uniform float mat_ka;
uniform vec4 mat_d_col;
uniform float mat_kd;
uniform vec4 mat_s_col;
uniform float mat_s_exp;
uniform float mat_ks;

// Outgoing fragment color
out vec4 fragColor;

void main()
{
    ///////////////////////////////////////////////////////
    // Add all illumination and shading code you need here
    ///////////////////////////////////////////////////////

    //Calculates the normal vector by simply normalizing the normal position
    vec4 normal_direction = normalize( normal );

    //Calculates the light vector by taking the normalized difference of the light position and vertex position
    vec4 light_direction = normalize( light_position - position );

    //Calculates cos theta by taking the dot product of the normal and light vectors, using max to ensure no negative values
    float dif = max( dot( normal_direction, light_direction), 0.0 );

    //Calculates the reflection vector by normalizing the reflection of the negative light vector over the normal vector
    vec4 reflect_direction = normalize( reflect( -light_direction, normal_direction) );

    //Calculates the view vector by simply normalizing the negative vertex position
    vec4 view_direction = normalize( -position );

    //Calculates cos alpha by taking the dot product of the reflection and view vectors, using max to ensure no negative values
    float dif2 = max( dot(reflect_direction, view_direction), 0.0);

    //Finally calculates the fragment color using the phong illumination model
    fragColor = a_col*mat_ka*mat_a_col + l_col*mat_kd*mat_d_col*dif + l_col*mat_ks*mat_s_col*pow(dif2, mat_s_exp);
}
