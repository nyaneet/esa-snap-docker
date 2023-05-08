from ubuntu:bionic

# Update packages and install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential \
    wget \ 
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools

# Install JDK and set JAVA_HOME env
RUN DEBIAN_FRONTEND=noninteractive apt-get install default-jdk maven -y
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Install SNAP Tollbox
COPY src /root/src
WORKDIR /root/src

RUN wget https://step.esa.int/downloads/9.0/installers/esa-snap_sentinel_unix_9_0_0.sh
RUN chmod +x ./esa-snap_sentinel_unix_9_0_0.sh

RUN sh ./esa-snap_sentinel_unix_9_0_0.sh -q -varfile ./response.varfile

# Configuring SNAP-Python interface
RUN chmod +x ./esa-snap_sentinel_unix_9_0_0.sh
RUN bash ./setup_python_interface.sh

# Clean image
RUN rm -rf /root/src

# Set entrypoint
WORKDIR /root
ENTRYPOINT ["/bin/bash"]
