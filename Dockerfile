FROM node:15.14.0-alpine3.12

# ENV name = metadata \
# version = 1.0  enter any environment variables necessary inside the container

LABEL maintainer "ssirimal@my.bridgeport.edu"

# HEALTHCHECK --interval=5s --timeout=5s CMD [ "curl -f http://127.0.0.1:3000 || exit 1" ]

RUN mkdir -p /home/app

COPY . /home/app

CMD [ "node", "/home/app/server.js" ]

# EXPOSE 8000 tells docker which port to expose

# a dockerfile can have multiple RUN commands but only one CMD command cause it is an entry point into the app