#!/bin/bash

echo "Entrez un nom d'addon: "
read nom_addon

echo "Entrez un nom : "
read nom_global

random=$(head /dev/urandom | tr -dc 'a-z0-9' | head -c 14)
echo "ID generer : $random"

readonly configfilename=$random"_config.lua"
touch $configfilename
cat configmodel.lua > $configfilename

sed -i "s/test/$nom_global/g" $configfilename
sed -i "s/random/$random/g" $configfilename

readonly svfilename=$random"_sv.lua"
readonly clfilename=$random"_cl.lua"

touch $svfilename
cat svmodel.lua > $svfilename
sed -i "s/cfgfilename/$configfilename/g" $svfilename

touch $clfilename
cat clmodel.lua > $clfilename
sed -i "s/cfgfilename/$configfilename/g" $clfilename

mkdir -p $nom_addon/lua/autorun/server
mkdir -p $nom_addon/lua/autorun/client

mv $configfilename $nom_addon/lua/
mv $svfilename $nom_addon/lua/autorun/server
mv $clfilename $nom_addon/lua/autorun/client
