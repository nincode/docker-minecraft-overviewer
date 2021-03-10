# Build from docker-compose
# sudo docker-compose build
#
# Build from docker (don't do this, use docker-compose instead):
# sudo docker build -t mc-overview:dev .
FROM ubuntu:20.04

WORKDIR /var/app

# COPY Minecraft-Overviewer/ /var/app
# This config will get overlaid with the real input data, but it will server as a default config
COPY overviewer_config.py /var/in/overviewer_config.py

# Get dependencies, apt-get, etc
RUN echo "Grabbing dependencies ============================================"
RUN apt-get update \
&& apt-get -y install apt-utils \
&& apt-get -y install python3-dev python3-pillow python3-numpy build-essential python3-pip wget git \
&& apt-get clean 

# Pull overviewer
RUN echo "Pulling overviewer ==============================================="
RUN git clone https://github.com/overviewer/Minecraft-Overviewer.git \
&& cd Minecraft-Overviewer \
&& git checkout 86963c5de9b237baab3b7be5b017500075357b17 \
&& python3 setup.py install

# Get minecraft textures
RUN echo "Getting minecraft textures ========================================" 
RUN VERSION=1.16.5 \
&& mkdir -p ~/.minecraft/versions/${VERSION}/ \
&& wget https://overviewer.org/textures/${VERSION} -O ~/.minecraft/versions/${VERSION}/${VERSION}.jar

# EXPOSE 3000

ENV NODE_ENV=production
CMD cd Minecraft-Overviewer && python3 overviewer.py --config=/var/in/overviewer_config.py

