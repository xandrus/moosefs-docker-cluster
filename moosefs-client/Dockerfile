FROM debian:buster

# Install wget, lsb-release, curl, fuse and tree
RUN apt-get update && apt-get install -y wget fuse libfuse2 gnupg2 python3

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/moosefs-3/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS client
RUN apt-get update && apt-get install -y moosefs-client moosefs-cli

RUN mkdir /mnt/moosefs
