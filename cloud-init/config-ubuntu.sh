#!/bin/bash
export USERNAME=kozlova
export WSVERSION=3.2


sudo apt install -y unzip shellinabox lynx w3m curl

tee -a ~/.profile <<EOF
helm() {
  if [ -z ${ACCESS_TOKEN+x} ]; then echo "ACCESS_TOKEN is unset. Please export ACCESS_TOKEN=YOUR_TOKEN"; return; fi
  if [[ ${#ACCESS_TOKEN} < 22 ]]; then echo "ACCESS_TOKEN looks too short. It should be a string of at least 22 characters."; return; fi
  if [ -z ${REALM+x} ]; then echo "REALM is unset. Please export REALM=YOUR_REALM"; return; fi
  if [[ ! $REALM  =~ ^(us0|us1|us2|eu0)$ ]]; then echo "REALM is not one of the supported realms. Check that it is one of us0, us1, us2 or eu0."; return; fi

  echo "Using ACCESS_TOKEN=$ACCESS_TOKEN"
  echo "Using REALM=$REALM"

  command helm "$@"
}

terraform() {
  if [ -z ${ACCESS_TOKEN+x} ]; then echo "ACCESS_TOKEN is unset. Please export ACCESS_TOKEN=YOUR_TOKEN"; return; fi
  if [ -z ${REALM+x} ]; then echo "REALM is unset. Please export REALM=YOUR_REALM"; return; fi

  echo "Using ACCESS_TOKEN=$ACCESS_TOKEN"
  echo "Using REALM=$REALM"

  command terraform "$@"
}

export INSTANCE=$(hostname)
export KUBECONFIG=/home/${USERNAME}/.kube/config
EOF

curl -sfL https://get.k3s.io | sh -
  # Install Helm
curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  # Install K9s (Kubernetes UI)
curl -S -OL https://github.com/derailed/k9s/releases/download/v0.24.14/k9s_Linux_x86_64.tar.gz
sudo tar xfz k9s_Linux_x86_64.tar.gz -C /usr/local/bin/ k9s
  # Download Workshop
  # export WSVERSION=3.1
export WSARCHIVE=$([ "$WSVERSION" = "master" ] && echo "master" || echo "v$WSVERSION")
curl -s -OL https://github.com/signalfx/observability-workshop/archive/$WSARCHIVE.zip
unzip -qq $WSARCHIVE.zip -d /home/${USERNAME}/
mv /home/${USERNAME}/observability-workshop-$WSVERSION /home/${USERNAME}/workshop
  # Download Splunk Observability Cloud Jumpstart
curl -s -L https://github.com/signalfx/signalfx-jumpstart/archive/master.zip -o jumpstart.zip
unzip -qq jumpstart.zip -d /home/${USERNAME}/
mv /home/${USERNAME}/signalfx-jumpstart-master /home/${USERNAME}/signalfx-jumpstart
  # Download Microservices Demo
curl -s -L https://github.com/signalfx/microservices-demo/archive/master.zip -o microservices-demo.zip
unzip -qq microservices-demo.zip -d /home/${USERNAME}/
mv /home/${USERNAME}/microservices-demo-master /home/${USERNAME}/microservices-demo
  # Configure motd - motd - MESSAGE OF TEH DAY - it's just cosmetics. we dont' need it
#curl -s https://raw.githubusercontent.com/signalfx/observability-workshop/master/cloud-init/motd -o /etc/motd
#sudo chmod -x /etc/update-motd.d/*
  # Install Terraform
curl -S -OL https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_linux_amd64.zip
sudo unzip -qq terraform_1.0.3_linux_amd64.zip -d /usr/local/bin
  # Create kube config and set correct permissions on ${USERNAME} user home directory
mkdir /home/${USERNAME}/.kube && sudo kubectl config view --raw > /home/${USERNAME}/.kube/config
#chmod 400 /home/${USERNAME}/.kube/config
#chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
  # Configure shellinabox port and disable ssl then restart
sudo sed -i 's/SHELLINABOX_PORT=4200/SHELLINABOX_PORT=6501/'  /etc/default/shellinabox
sudo sed -i "s/\"--no-beep\"/\"--no-beep --disable-ssl\"/" /etc/default/shellinabox
sudo service shellinabox restart
  # Install AWS CLI
  #- curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
  #- unzip -qq awscliv2.zip
  #- ./aws/install
  # Install eksctl for AWS/EKS
  #- curl -s --silent --location https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz | tar xz -C /tmp
  #- mv /tmp/eksctl /usr/local/bin/
  # Install nodejs and puppeteer
  #temporary add for Cold start RUM
sudo apt install -y libgbm-dev gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs