# story-monitoring

## Install Docker Engine 
You need installed docker engine on server before got to next step:
[How to install docker](https://docs.docker.com/engine/install/ubuntu/)

## Install monitoring for story

```bash
wget -O install.sh https://raw.githubusercontent.com/Crouton-Digital/story-monitoring/refs/heads/main/install.sh && chmod +x install.sh && sudo ./install.sh
```

## Configuration 
### Configure exporter
Edit docker-compose.yml, need enter you validator address and node rpc url 

```bash 
  story-validator-exporter:
    image: ghcr.io/crouton-digital/story-validator-exporter:v0.12.2
    container_name: cosmos-validator-watcher
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

### Alerting configuration

Goto Home -> Alerting -> Contact Point and press "Add contact point"  

![ContactPoint_01.png](docs%2Fimages%2FContactPoint_01.png)

```bash 
{{ template "telegram.message" . }}
```
Press "Save contact point" button

On Notification templates Press "Add template" button 

Enter name: temp.messages

content paste: 
```bash 
{{ define "telegram.print_alert" -}}
[{{.Status}}] {{ .Labels.alertname }}
{{ if .Annotations -}}
Annotations:
{{ range .Annotations.SortedPairs -}}
- {{ .Name }}: {{ .Value }}
{{ end -}}
{{ end -}}
{{ if .DashboardURL -}}
  Go to dashboard: {{ .DashboardURL }}
{{- end }}
{{- end }}

{{ define "telegram.message" -}}
{{ if .Alerts.Firing -}}
{{ len .Alerts.Firing }} firing alert(s):
{{ range .Alerts.Firing }}
{{ template "telegram.print_alert" . }}
{{ end -}}
{{ end }}
{{ if .Alerts.Resolved -}}
{{ len .Alerts.Resolved }} resolved alert(s):
{{ range .Alerts.Resolved }}
{{ template "telegram.print_alert" .}}
{{ end -}}
{{ end }}
{{- end }}
```
For save press "Save template" button  

Goto Home -> Alerting -> Notification policies and press "New nested policy"  

![Notifypolicy_01.png](docs%2Fimages%2FNotifypolicy_01.png)  

and fill in all the fields as in the example below:  
![Notifypolicy_02.png](docs%2Fimages%2FNotifypolicy_02.png)  
for save changes press "Save policy" button  

## Cleanup all container data
```bash 
cd /opt/story-monitoring/
sudo docker-compose down
sudo docker volume prune -f
sudo rm -rf /opt/story-monitoring/
```

## Reference list
Resources we used in this project:
* Story validator exporter: (https://github.com/Crouton-Digital/story-validator-exporter)
