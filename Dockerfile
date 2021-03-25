FROM ubuntu:bionic

# prepare OS
RUN apt-get update && apt-get install -y \
    # for chrome
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libnspr4 libnss3 lsb-release xdg-utils libxss1 libdbus-glib-1-2 libgbm1 \
    # common
    curl unzip wget xvfb \
    # for npm
    build-essential

# node js v15
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Google Chrome
RUN CHROME_SETUP=google-chrome.deb \
# uncomment for latest
#    wget -O $CHROME_SETUP "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" && \
    && wget -O $CHROME_SETUP "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_89.0.4389.90-1_amd64.deb" \
    && dpkg -i $CHROME_SETUP \
    && apt-get install -y -f \
    && rm $CHROME_SETUP

RUN CHROMEDRIVER_VERSION="89.0.4389.23" \
# uncomment for latest
# CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    && wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip -d /usr/bin \
    && chmod +x /usr/bin/chromedriver \
    && rm chromedriver_linux64.zip
