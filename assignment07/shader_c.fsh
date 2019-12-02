#version 150

in vec4 vPosition;
in vec3 vNormal;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec3 uLightPosition;
uniform vec3 uLightColor;
uniform float uLightSpotLightFactor;

uniform mat3 uAmbientMaterial;
uniform mat3 uDiffuseMaterial;
uniform mat3 uSpecularMaterial;
uniform float uSpecularityExponent;

out vec4 oFragColor; //write the final color into this variable

void main() {
          vec4 newPosition = uModelViewMatrix * vPosition;
    vec3 global_origin=vec3(uModelViewMatrix*vec4(0,0,0,1));

    // Transform normals using the correct matrix.
    // It's important to normalize in the end
    //vec3 newNormal =
    //gl_Position = write the final vertex position into this variable
    //gl_Position = uProjectionMatrix * newPosition;

    // Define the color of this vertex
    vec3 w_l=normalize(uLightPosition-vec3(newPosition));
    vec3 w_v=normalize(vec3(0,0,0)-vec3(newPosition));
    vec3 h=normalize(w_l+w_v);
    vec3 n= normalize(vec3(uModelViewMatrix*vec4(vNormal,1.0)));

    // Define the color of this vertex
    float att=1/(abs(distance(uLightPosition,vec3(newPosition)))+distance(uLightPosition,vec3(newPosition))*distance(uLightPosition,vec3(newPosition)));

    float spot=abs(dot(normalize(uLightPosition-global_origin),w_l));


    float spot_f=pow(spot,uLightSpotLightFactor);
    vec3 vColor =
    uAmbientMaterial*uLightColor
    +spot_f
    *(uDiffuseMaterial*uLightColor*dot(w_l,vNormal)
    +(uSpecularMaterial*uLightColor) *pow((dot(n,h)),uSpecularityExponent));
      oFragColor=vec4(vColor,1.0f);
}
