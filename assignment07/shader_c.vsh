#version 150

in vec4 aPosition;
in vec3 aNormal;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

out vec4 vPosition;
out vec3 vNormal;

void main() {
    // Transform to eye-space
    // vPosition = uModelViewMatrix * aPosition;
    //vNormal =
    //gl_Position = write the final vertex position into this variable
        vec4 newPosition = uModelViewMatrix * aPosition;
        gl_Position = uProjectionMatrix * newPosition;
        vNormal=aNormal;
        vPosition=aPosition;
    // Transform normals using the correct matrix.
    // It's important to normalize in the end
    //vec3 newNormal =
    // gl_Position = write the final vertex position into this variable

}
