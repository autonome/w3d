FROM debian:jessie

RUN apt-get update && apt-get install -y rsync binutils wget

CMD cd /opt/build/debinstall && ./package.sh
