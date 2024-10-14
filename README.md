# story-monitoring

## Install Docker Engine 
You need installed docker engine on server before got to next step:
[How to install docker](https://docs.docker.com/engine/install/ubuntu/)

## Install monitoring for story

```bash
wget -O install.sh https://raw.githubusercontent.com/Crouton-Digital/story-monitoring/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```

## Configuration 
### Configure exporter
Edit docker-compose.yml, need enter you validator address and node rpc url 

```bash 
  story-validator-exporter:
    image: ghcr.io/crouton-digital/story-validator-exporter:v0.12.2
    container_name: cosmos-validator-watcher
    labels:
      network: "mainnet"
    command: >
      --log-level debug
      --validator BAED8E3FAD9FD20457EA2AD53A631AFAA6477F3A:CroutonDigital  # Replace to your validator address 
      --node http://127.0.0.1:26657  # Replace to your node rpc url 
      --node https://story-testnet-rpc.validator247.com
      --node https://story-testnet-rpc.itrocket.net
```
after edit, need apply changes 
```bash
docker compose up -d 
```

### Configure Grafana
1. Open Grafana in your web browser. It should be available on port 3000

![grafana_login_01.png](docs%2Fimages%2Fgrafana_login_01.png)

2. Login using defaults admin/admin and change password

![grafana_login_02.png](docs%2Fimages%2Fgrafana_login_02.png)

3. Go to Dashboard  

Validator stats - information about validator such as rank, bounded tokens, comission, delegations and rewards  
![dashboard01.png](docs%2Fimages%2Fdashboard01.png)  

Hardware health - system hardware metrics. cpu, ram, network usage  
![dashboard02.png](docs%2Fimages%2Fdashboard02.png)  

## Cleanup all container data
```bash 
cd /opt/story-monitoring/
docker-compose down
docker volume prune -f
```

## Reference list
Resources we used in this project:
* Story validator exporter: (https://github.com/Crouton-Digital/story-validator-exporter)
