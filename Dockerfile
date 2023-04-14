#######################################
# Docker Environment to run local LLM #
#######################################

FROM ubuntu:20.04

###############
# Environment #
###############

ENV LANG=en_US.utf-8
ENV LC_ALL=en_US.utf-8

ENV NODE_VERSION=18.15.0
ENV NVM_DIR=/root/.nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

ENV DEBIAN_FRONTEND="noninteractive"

ENV JUPYTERLAB_VERSION="3.2.1"

###########
# General #
###########

RUN apt-get update && \
    apt-get install -y curl wget git python3-pip python3.8

RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

######################
# Create Environment #
######################

# RUN cd /opt
# RUN virtualenv --python=python3.8 env
# RUN source env/bin/activate

###########
# gpt4all #
###########

RUN curl https://the-eye.eu/public/AI/models/nomic-ai/gpt4all/gpt4all-lora-quantized.bin -o gpt4all-lora-quantized.bin

RUN git clone https://github.com/nomic-ai/gpt4all.git

RUN mv gpt4all-lora-quantized.bin gpt4all/chat/

RUN pip install nomic

###################
# Jupyter Kernels #
###################

# -- Layer: JupyterLab + Python kernel

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install wget==3.2 jupyterlab==${JUPYTERLAB_VERSION}

# RUN apt-get install -y r-base-dev && \
#     R -e "install.packages('IRkernel')" && \
#     R -e "IRkernel::installspec(displayname = 'R 3.5', user = FALSE)"

##########
# FINISH #
##########

ADD docker_start.sh /docker_start.sh

#Run at container start
CMD ["/bin/bash","/docker_start.sh"]
