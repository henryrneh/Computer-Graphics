#version 150

in vec4 aPosition;
in vec3 aNormal;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec3 uLightPosition;
uniform vec3 uLightColor;
uniform float uLightSpotLightFactor;

uniform mat3 uAmbientMaterial;
uniform mat3 uDiffuseMaterial;
uniform mat3 uSpecularMaterial;
uniform float uSpecularityExponent;

out vec3 vColor;

void main() {
    // Transform to eye-space
    vec4 newPosition = uModelViewMatrix * aPosition;
    vec3 global_origin=vec3(uModelViewMatrix*vec4(0,0,0,1));

    // Transform normals using the correct matrix.
    // It's important to normalize in the end
    //vec3 newNormal =
    //gl_Position = write the final vertex position into this variable
    gl_Position = uProjectionMatrix * newPosition;
           vec3 position_3;
    if(newPosition.w != 0.0){
      position_3 = vec3(newPosition.x/newPosition.w, newPosition.y/newPosition.w , newPosition.z/newPosition.w);
     } 
    else position_3 = vec3(newPosition);

    // Define the color of this vertex
    vec3 w_l=normalize(uLightPosition-position_3);
    vec3 w_v=normalize(vec3(0,0,0)-position_3);
    vec3 h=normalize(w_l+w_v);
    vec3 n= normalize(vec3(uModelViewMatrix*vec4(aNormal,1.0)));

    // Define the color of this vertex
    float att=1/(abs(distance(uLightPosition,position_3))+distance(uLightPosition,position_3)*distance(uLightPosition,position_3));

    float spot=abs(dot(normalize(uLightPosition-global_origin),-w_l));


    float spot_f=pow(spot,uLightSpotLightFactor);
    vColor =
    uAmbientMaterial*uLightColor
    +spot_f
    *(uDiffuseMaterial*uLightColor*dot(w_l,aNormal)
    +(uSpecularMaterial*uLightColor) *pow((dot(n,h)),uSpecularityExponent));
}
