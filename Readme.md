# Resource provision

```bash

    git clone https://github.com/FourTimes/demo-proect.git
    cd demo-proect
    cd _terraform

    # befor the u have to assign the access and secret key in provider.tf
    terraform init
    terraform plan -var-file=production.tfvars
    terraform apply -var-file=production.tfvars -auto-approve

```
# nodeJS

    curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo apt-get update && sudo apt-get install yarn -y
    sudo npm install -g @angular/cli

```bash

    cd /home/ubuntu/
    git clone https://github.com/FourTimes/demo-proect.git
    cd demo-proect
    cd dodonotdo
    npm i
    cd ..
    cd _api_server

```


```bash

    # vim /lib/systemd/system/api_service.service

    [Unit]
    Description=hello_env.js - making your environment variables rad
    Documentation=https://example.com
    After=network.target

    [Service]
    Environment=NODE_PORT=4000
    Type=simple
    User=ubuntu
    ExecStart=/usr/bin/node /home/ubuntu/Desktop/_demo/dodonotdo/index.js
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target

```

```bash

    sudo systemctl daemon-reload 
    sudo systemctl start api_service
    ss -tulpn | grep 4000

```

```bash

curl xxx.xxx.xxx.xxx:4000/
     xxx.xxx.xxx.xxx:4000/data
     xxx.xxx.xxx.xxx:4000/healthz

```


```bash

    # vim /lib/systemd/system/angular_service.service

    [Unit]
    Description=hello_env.js - making your environment variables rad
    After=network.target

    [Service]
    Type=simple
    User=ubuntu
    ExecStart=ng serve 
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target

```

```bash

    sudo systemctl daemon-reload 
    sudo systemctl start angular_service
    ss -tulpn | grep 4200

```
