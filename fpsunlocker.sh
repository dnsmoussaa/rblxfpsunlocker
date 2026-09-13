#!/bin/bash

ROBLOX="/Applications/Roblox.app"
CLIENT_SETTINGS="$ROBLOX/Contents/MacOS/ClientSettings"
SETTINGS_FILE="$CLIENT_SETTINGS/ClientAppSettings.json"
mkdir -p "$CLIENT_SETTINGS"
REPONSE=""

echo " ████  █   █  ████ █   █  ███  █   █  ████  ████  ███      █ █████ ████   ████ █   █ █   █ █      ███   ███  █   █ █████ ████  
█   █ ██  █ █     ██ ██ █   █ █   █ █     █     █   █    █  █     █   █ █     █   █ ██  █ █     █   █ █     █  █  █     █   █ 
█   █ █ █ █  ███  █ █ █ █   █ █   █  ███   ███  █████   █   ████  ████   ███  █   █ █ █ █ █     █   █ █     ███   ████  ████  
█   █ █  ██     █ █   █ █   █ █   █     █     █ █   █  █    █     █         █ █   █ █  ██ █     █   █ █     █  █  █     █  █  
████  █   █ ████  █   █  ███   ███  ████  ████  █   █ █     █     █     ████   ███  █   █ █████  ███   ███  █   █ █████ █   █  "

echo
echo
read -p "Entrez vos FPS (ex: 120, 144, 165, 240, 9999) : " FPS 

if ! [[ "$FPS" =~ ^[0-9]+$ ]]; then
    echo "Entrez une valeur valide qui ne contient que des chiffres"
    exit 1
fi

cat > "$SETTINGS_FILE" <<EOF
{
    "DFIntTaskSchedulerTargetFps": $FPS,
    "FFlagDebugGraphicsDisableMetal": "True",
    "FFlagDebugGraphicsPreferOpenGL": "True"
}
EOF

echo "Vos FPS ont bien été modifiés, il sera cappés au maximum à : $FPS FPS. "

while [[ "$REPONSE" != "oui" && "$REPONSE" != "non" ]]; do
    read -p "Souhaitez-vous modifier vos paramètres Roblox afin d'avoir un gain de FPS plus impressionnant ? (oui/non) : " REPONSE
    
    if [[ "$REPONSE" != "oui" && "$REPONSE" != "non" ]]; then
        echo "Veuillez taper uniquement 'oui' ou 'non'."
    fi
done

case "$REPONSE" in 
non)
echo "Aucune modification n'a été apporté à votre fichier Roblox" 
;;
oui)
cat > "$SETTINGS_FILE" <<EOF
{
    "DFIntTaskSchedulerTargetFps": $FPS,
    "FFlagDebugGraphicsDisableMetal": "True",
    "FFlagDebugGraphicsPreferOpenGL": "True",
    "FIntDebugForceMSAASamples": 0,
    "FIntFRMMaxGrassDistance": 0,
    "FIntFRMMinGrassDistance": 0,
    "FIntGrassMovementReducedMotionFactor": 0,
    "DFFlagDebugPauseVoxelizer": "True",
    "DFIntCSGLevelOfDetailSwitchingDistance": 0,
    "DFIntCSGLevelOfDetailSwitchingDistanceL12": 0,
    "DFIntCSGLevelOfDetailSwitchingDistanceL23": 0,
    "DFIntCSGLevelOfDetailSwitchingDistanceL34": 0,
    "DFFlagTextureQualityOverrideEnabled": "True",
    "FFlagDebugSkyGray" : "True",
    "DFIntTextureQualityOverride": 1
}
EOF
echo "Des FFLags supplémentaires ont été ajoutés à vos paramètres."
;;
esac 

echo "Votre fichier roblox à bien été modifié, merci d'avoir utilisé mon script."

