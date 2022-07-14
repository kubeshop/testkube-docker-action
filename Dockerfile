FROM alpine:latest

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin

# Install wget to download testkube
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl jq \
 && if ${VERSION} ; \
    then \
      if curl -s -f --output /dev/null --connect-timeout 5 https://api.github.com/repos/kubeshop/testkube/releases/latest; \
        then export VERSION=$(curl -s -f https://api.github.com/repos/kubeshop/testkube/releases/latest | jq -r .tag_name | cut -c2-); \
      else \
        echo "VERSION is not set, and GitHub repo is unavailable, exiting"; \
        exit 1; \
      fi \
    fi

 # Configure testkube
 RUN mkdir .testkube && echo "{}" > .testkube/config.json

 # Download testkube and move to bin directory
 RUN curl -L "https://github.com/kubeshop/testkube/releases/download/v${VERSION}/testkube_${VERSION}_${PLATFORM}.tar.gz" | tar -xzvf - \
  && mv kubectl-testkube /usr/local/bin/testkube \
  && chmod +x /usr/local/bin/testkube

# Clean installation
RUN apt-get remove -y curl jq

# Switch to non-root user
RUN addgroup teskube && adduser -S -G testkube testkube
USER testkube
