//
//  Lighting
//
//  Simple module for setting up the parameters for lighting and shading
//  for the Shading Assignment.
//
//  Created by Warren R. Carithers 2019/11/18.
//  Updated: 2021/11/07 by wrc
//  Copyright 2021 Rochester Institute of Technology.  All rights reserved.
//
//  Contributor:  Nicholas Shinn
//

#include "Lighting.h"

#include "Models.h"
#include "Utils.h"

using namespace std;

//////////////////////////////////////////////////////
// Add any global variables you need here.
//////////////////////////////////////////////////////

// Light source properties
GLfloat src_col[] = { 1.0, 1.0, 0.0, 1.0 };
GLfloat src_pos[] = { 0.0, 5.0, 2.0, 1.0 };

// Ambient light properties
GLfloat amb_col[] = { 0.5, 0.5, 0.5, 1.0 };

// Teapot material properties
GLfloat tea_amb_col[] = { 0.5, 0.1, 0.9, 1.0 };
GLfloat tea_ka = 0.5;
GLfloat tea_dif_col[] = { 0.89, 0.0, 0.0, 1.0 };
GLfloat tea_kd = 0.7;
GLfloat tea_sp_col[] = { 1.0, 1.0, 1.0, 1.0 };
GLfloat tea_sp_exp = 10.0;
GLfloat tea_ks = 1.0;

// Torus material properties
GLfloat tor_col[] = { 0.1, 0.85, 0.2, 1.0 };
GLfloat tor_ka = 0.5;
GLfloat tor_kd = 0.7;
GLfloat tor_sp_col[] = { 1.0, 1.0, 1.0, 1.0 };
GLfloat tor_sp_exp = 50.0;
GLfloat tor_ks = 1.0;

///
/// This function sets up the lighting, material, and shading parameters
/// for the shaders.
///
/// You will need to write this function, and maintain all of the values
/// needed to be sent to the vertex shader.
///
/// @param program  The ID of an OpenGL (GLSL) shader program to which
///    parameter values are to be sent
/// @param obj      Which object is currently being drawn
///
void setLighting( GLuint program, Shape obj )
{
    //////////////////////////////////////////////////////
    // Add your code to pass the lighting and shading data
    // to the shader programs.
    //////////////////////////////////////////////////////

    //Gets the locations of the light vectors from the shaders
    GLint lightcol = glGetUniformLocation( program, "l_col" );
    GLint lightpos = glGetUniformLocation( program, "l_pos" );
    GLint ambcol = glGetUniformLocation( program, "a_col" );

    //Gets the location of the ambient variables from the shaders
    GLint mambcol = glGetUniformLocation( program, "mat_a_col" );
    GLint mka = glGetUniformLocation( program, "mat_ka" );

    //Gets the locations of the diffuse variables from the shaders
    GLint mdifcol = glGetUniformLocation( program, "mat_d_col" );
    GLint mkd = glGetUniformLocation( program, "mat_kd" );

    //Gets the locations of the specular variables from the shaders
    GLint mspcol = glGetUniformLocation( program, "mat_s_col" );
    GLint mspexp = glGetUniformLocation( program, "mat_s_exp" );
    GLint mks = glGetUniformLocation( program, "mat_ks" );

    //Sets the light vectors in the shaders from the provided values
    glUniform4fv( lightcol, 1, src_col );
    glUniform4fv( lightpos, 1, src_pos );
    glUniform4fv( ambcol, 1, amb_col );

    //If the provided shape is a teapot, send the teapot material properties to the shader. Otherwise, send the torus material properties
    if( obj == Shape::Teapot ){
	    glUniform4fv( mambcol, 1, tea_amb_col );
	    glUniform1f( mka, tea_ka );

	    glUniform4fv( mdifcol, 1, tea_dif_col );
	    glUniform1f( mkd, tea_kd );

	    glUniform4fv( mspcol, 1, tea_sp_col );
	    glUniform1f( mspexp, tea_sp_exp );
	    glUniform1f( mks, tea_ks );
    } else {
	    glUniform4fv( mambcol, 1, tor_col );
            glUniform1f( mka, tor_ka );

            glUniform4fv( mdifcol, 1, tor_col );
            glUniform1f( mkd, tor_kd );

            glUniform4fv( mspcol, 1, tor_sp_col );
            glUniform1f( mspexp, tor_sp_exp );
            glUniform1f( mks, tor_ks );
    }
}
