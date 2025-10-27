FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base tools
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        git \
        jq \
        ca-certificates \
        build-essential \
        unzip \
        gnupg \
        lsb-release \
        make \
        software-properties-common

# Install Docker CLI
RUN apt-get install -y docker.io

# Install SonarScanner
RUN wget -O /tmp/sonar-scanner.zip \
      https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    unzip /tmp/sonar-scanner.zip -d /opt && \
    ln -s /opt/sonar-scanner-*/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm /tmp/sonar-scanner.zip

# Install Trivy (fixed way)
RUN wget -O /tmp/trivy.deb https://github.com/aquasecurity/trivy/releases/download/v0.64.1/trivy_0.64.1_Linux-64bit.deb && \
    apt-get update && \
    apt-get install -y /tmp/trivy.deb && \
    rm /tmp/trivy.deb


# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash



