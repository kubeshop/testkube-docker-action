FROM alpine:latest

USER root

ENV PLATFORM="Linux_x86_64"

# Install curl to download testkube
RUN apk update && apk --no-cache add curl jq

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin

# Download testkube and move to bin directory
RUN VERSION=`curl -s -f https://api.github.com/repos/kubeshop/testkube/releases/latest | jq -r .tag_name | cut -c2-` \
 && curl -L "https://github.com/kubeshop/testkube/releases/download/v${VERSION}/testkube_${VERSION}_${PLATFORM}.tar.gz" | tar -xzvf - \
 && mv kubectl-testkube /usr/local/bin/testkube \
 && chmod +x /usr/local/bin/testkube

# Configure testkube
RUN mkdir .testkube && echo "{}" > .testkube/config.json

# Clean installation
RUN rm -rf LICENSE README.md && apk del curl jq

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
