FROM circleci/openjdk:8
MAINTAINER Matt Strenz <mstrenz@gmail.com>
USER root

ENV DISPLAY=:1.0
RUN apt-get update && apt-get install -y vim xvfb python3
RUN apt-get upgrade -y
RUN apt-get update -y
RUN apt-get install -y default-jre-headless python3-tk python3-pip python3-dev libxml2-dev libxslt-dev zlib1g-dev
RUN pip3 install --upgrade pip
RUN pip3 install lxml
RUN pip3 install psutil
RUN pip3 install bzt
RUN pip3 install --upgrade bzt

RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/*

ENV env https://project-nibbler.herokuapp.com
ENV users 5
ENV length 60s
ENV token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJJZCI6IjAwRDZBMDAwMDAxV2hPRlVBMC8wMDU2QTAwMDAwME5rTkJRQTAiLCJVc2VybmFtZSI6Im1hdHRAc3Bva2UtcWEuY29tIiwiT3JnYW5pemF0aW9uIjoiMDBENkEwMDAwMDFXaE9GVUEwIiwiVXNlcl9JZCI6IkhrTlBpV0RtWiIsIkluc3RhbmNlVXJsIjoiaHR0cHM6Ly9hcHRvdHVkZS0zMzI1LmNsb3VkZm9yY2UuY29tIiwiRW1haWwiOiJtc3RyZW56QGFwdG8uY29tIiwiTGVnYWN5VXNlcklkIjoiSGtOUGlXRG1aIiwiU2ZDb25uZWN0aW9uRGV0YWlscyI6eyJkZXRhaWxzIjoiWmpFMll6QmxaR1UzWW1ZelpXTm1NV0ptWlRjd1pUWTNZVGM1WVRVMU1EY3dPREEzTnpreU1UTmhNVFk1WVRObFlqQTVPREEzTWpBMU9URmpOak16WmpFNU5ERTRNV1kwT0dGbFpHVXlNREptWmpGbU9UVm1Nak5oTVRZME5EUXlaV1ZoWTJNMk1EWmtNemc1T1dNd09UWXpObUl4TTJNeVpEVXhNVEF4TmpnelltTXhZV1JrTmpreE5EZGtaVEUwWWpObFpHRXpOVEl3WlRjeU5qQmhPVEEzTUdNMVl6SXlNakF6TkRrek5XVTVaVGxpTmpoalltWXpZVFl3WVRJMlpUTmhZMlptTURneU9XVTVORGczWW1VNU4yWmpNMk5tWmpNMU56YzVZVGxoTVRWbU16bG1ZakkxWTJFd09HSTVZbUl4Wm1SallUTXpOemd6Tm1Wa01EZGhaV1ZrTkRSaFl6TmlNalV3TlRjeE56aGxaak14TnpjMFltTTRNbUl4TWpoaVpqUXlOV0V5T0RkaFlqUXlObUV3TW1GallqUm1ZalJrT1dGbU9UVmpaREJtTlRFd1ptRmhNREl5WXpoak5UWXlaRFEwTVRrMlltTmtNalJqWmpWbU5tSXpabVUyT1dVMlpUUmxaREJtT0dGall6TTROak5oTkRObFpUVTJOR0l5WlRRNVkyTmlORFV6TnpVMk1UUTJNMkV6TldWaU4yVTFaV1U0WlRjMU16STNPR0U1TmpRME9EZG1ZemxpT1RGallUSTBOREEwTTJabE9HVmxZbVJrWkRRek9USXhabVUxTlRZek16TmxaV0UzTXpFeVlURTBNamt3TkRVek4yWmxORGd4TkRnNU16Z3lNV1JqTWpVMFpUSmxZelptTmpnNFptUmxPVEV3TmpVd05UTmhOek5tTUdWbVlqaGtObVZqTW1Sak4yWXdPR00xWm1ReVpUUXhOamxrTjJGaE9EVXlaakE0WmpReU1UazVPR1EzWW1FNU56TXhaamhtIiwiaW5zdGFuY2VVcmwiOiJodHRwczovL2FwdG90dWRlLTMzMjUuY2xvdWRmb3JjZS5jb20ifSwiaWF0IjoxNTM0MjkwNTQxLCJpc3MiOiJhcHRvLWFwaSIsImVuYWJsZWRGZWF0dXJlcyI6WyJtYXBwaW5nX3YxIiwiTGlzdGluZ3MiLCJMZWFzaW5nIiwiRGVhbHMiXX0.40bMfB3fnWgW4zOMAlFY7ZAdQ27Tg3Nz-R3ZStR1nxQ

RUN mkdir /tmp/load
WORKDIR /tmp/load
ENV HOME /tmp/load

COPY quick_test.yml /tmp/load
COPY site_test.yml /tmp/load
COPY runTest.sh /tmp/load


VOLUME /results
RUN chmod a+w /results /tmp/load

RUN bzt quick_test.yml
#RUN rm -r /tmp/load/*-*-*_*-*-*.*
#RUN chmod a+x .bzt/jmeter-taurus/bin/jmeter .bzt/jmeter-taurus/bin/jmeter-server .bzt/jmeter-taurus/bin/*.sh
#RUN ln -s .bzt/jmeter-taurus/bin/jmeter
#RUN ln -s .bzt/jmeter-taurus/bin/jmeter-server

CMD ./runTest.sh
 
