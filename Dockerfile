# Inherit from Heroku's node stack
FROM heroku/nodejs
ENV NODE_ENGINE 4.1.1

# Install OpenCV
RUN mkdir -p /app/.heroku/opencv /tmp/opencv
ADD Install-OpenCV /tmp/opencv
WORKDIR /tmp/opencv/Ubuntu
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse' >> /etc/apt/sources.list && apt-get update
RUN ./opencv_latest.sh

RUN echo "export PATH=\"/app/heroku/node/bin:/app/user/node_modules/.bin:\$PATH\"" > /app/.profile.d/nodejs.sh

ONBUILD ADD package.json /app/user/
ONBUILD RUN /app/heroku/node/bin/npm install
ONBUILD ADD . /app/user/
