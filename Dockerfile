FROM jenkins/jenkins:2.440.1-jdk17

# Switch to root user for installation
USER root

# Install SSH server
RUN apt-get update \
    && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo 'PermitUserEnvironment yes' >> /etc/ssh/sshd_config \
    && echo 'export PATH=$PATH:/usr/local/bin/' >> /etc/profile

# Expose SSH port
EXPOSE 22

# Switch back to the Jenkins user
USER jenkins
