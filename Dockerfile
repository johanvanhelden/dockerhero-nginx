FROM nginx:stable

MAINTAINER Johan van Helden <johan@johanvanhelden.com>

ARG TZ=Europe/Amsterdam
ENV TZ ${TZ}

# Set the timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the self-signed certificates
ADD ./.certs /etc/nginx/conf.d/dockerhero/certs

# Add the core configuration
ADD ./.conf /etc/nginx/conf.d/dockerhero/core

# Overwrite the default.conf with our version
COPY ./.conf/default.conf /etc/nginx/conf.d/default.conf

# Remove the old mime types
RUN rm /etc/nginx/mime.types

# Add the new mime types
COPY ./.mime/mime.types /etc/nginx/mime.types
