#! /bin/bash
# Bash script para construir imagen desde cero y salvarla
# Setear antes las env vars con los paswords
# Ojo asegurarse de que el siguiente cd sea el directorio raiz del proyecto!!!
cd /c/Users/sferro/Documents/Trabajo/Projects/SmartModel/SmartModelV2/
echo "Inicio construcción de imagen bsm-studio-paq:v2.7"
echo $DOCKER_PWD | docker login  -u "sebastianf101" --password-stdin docker.io
docker build -t bsm-studio-paq -f Instal/Dockerfile.bsm-studio-paq.v2 . #--no-cache 
docker tag bsm-studio-paq sebastianf101/bsm-studio-paq:v2.7
# Sólo se permite un sólo repo privado en Docker Hub
# docker push sebastianf101/bsm-studio-paq:v2.7
echo "Inicio construcción de imagen bsm-studio:v10.3"
docker build -t bsm-studio-ssh -f Instal/Dockerfile.bsm-studio.v2 --progress=plain . #--no-cache 
docker tag bsm-studio-ssh sebastianf101/bsm-studio:v10.3
echo "Fin de construcción de imagen"
echo "Inicio subida a docker Hub"
docker push sebastianf101/bsm-studio:v10.3
docker logout docker.io
echo "Fin subida a docker Hub"
echo "Inicio subida a GitHub Container Registry"
echo $GHCR_PUSH_PWD | docker login -u sferro-besmart --password-stdin ghcr.io 
docker tag bsm-studio-ssh ghcr.io/sferro-besmart/smartmodelv2:v10.3.0
docker push ghcr.io/sferro-besmart/smartmodelv2:v10.3.0
docker logout ghcr.io
echo "Fin subida a GitHub Container Registry"
#docker save sebastianf101/bsm-studio:v10.3 | gzip -9 > Instal/bsm-studio-v10.3.tar.gz




