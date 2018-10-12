# Use official Debian sid runtime as a parent image
#FROM ubuntu:14.04
FROM node:9
EXPOSE 80 8001

# Set the working directory
# WORKDIR /usr/src/app
WORKDIR /home/ec2-user/

# Environment for RDS
ENV RDS_DB_NAME cloudnet
ENV RDS_HOSTNAME db-cloud-net.cvrnywdkyj6o.us-east-2.rds.amazonaws.com
ENV RDS_PASSWORD ******
ENV RDS_PORT 3306
ENV RDS_USERNAME wayne

# Copy the current directory to the container
COPY . .
RUN uname

RUN apt-get update \
    && apt-get install -y \
    memcached \
    npm \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    nginx \
    libmemcached-dev \
    zlib1g-dev \
    build-essential \
    redis-server \
    && pip3 install --upgrade pip \
    && pip3 install -r requirements.txt \
    && rm -rf /etc/nginx/sites-enabled \
    && mkdir /etc/nginx/sites-enabled \
    && cp cloud_net_nginx.conf /etc/nginx/sites-enabled/

# Start webapp
ENV PYTHONUNBUFFERED 0
CMD /etc/init.d/nginx restart && npm install webpack && npm install && npm run build && npm run start_uwsgi
