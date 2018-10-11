# Use official Debian sid runtime as a parent image
#FROM ubuntu:14.04
FROM node:9
EXPOSE 80 8001

# Set the working directory
# WORKDIR /usr/src/app
WORKDIR /home/ubuntu/cloud_net

# Environment for RDS
#ENV RDS_DB_NAME cs436
#ENV RDS_HOSTNAME cs436-db.cwf9oicgjnlk.us-east-2.rds.amazonaws.com
#ENV RDS_PASSWORD wulindiaoman
#ENV RDS_PORT 3306
#ENV RDS_USERNAME root

# Copy the current directory to the container
COPY . .
RUN uname

#RUN sudo apt-get update \
#    && sudo apt-get install -y python3.5 \
#    python3-dev \
#    python3-pip
# Install python, npm and mysql

RUN apt-get update \

    && apt-get install -y \
    memcached \
    # nodejs \
    npm \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    nginx \
    libmemcached-dev \
    zlib1g-dev \
    build-essential \
    && pip3 install --upgrade pip \
    && pip3 install -r requirements.txt \
    && rm -rf /etc/nginx/sites-enabled \
    && mkdir /etc/nginx/sites-enabled \
    && cp cloud_net_nginx.conf /etc/nginx/sites-enabled/
    # && npm config set strict-ssl false \
    # && npm install npm -g

# Start webapp
ENV PYTHONUNBUFFERED 0
# CMD /etc/init.d/nginx restart && npm install webpack && npm install && npm run build && npm start_uwsgi
