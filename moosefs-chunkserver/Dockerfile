FROM debian:buster

# Install wget, lsb-release and curl
RUN apt-get update && apt-get install -y wget gnupg2

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/moosefs-3/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS chunkserver
RUN apt-get update && apt-get install -y moosefs-chunkserver

RUN mkdir /mnt/hdd{0..12}
RUN echo "/mnt/hdd0" > /etc/mfs/mfshdd.cfg

# Expose ports
EXPOSE 9419 9420 9422

CMD ["mfschunkserver", "-f"]
