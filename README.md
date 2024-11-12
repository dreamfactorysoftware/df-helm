<h1 align="center">
    <a href="https://dreamfactory.com/"><img src="https://raw.githubusercontent.com/dreamfactorysoftware/dreamfactory/master/readme/vertical-logo-fullcolor.png" alt="DreamFactory" width="250" /></a>
</h1>

<p align="center">
    Helm Chart for DreamFactory 6.x
</p>

<p align="center">
    <a href="http://guide.dreamfactory.com/">Get Started Guide</a> ∙ <a href="https://genie.dreamfactory.com">Try Online</a> ∙ <a 
href="https://github.com/dreamfactorysoftware/dreamfactory/blob/master/CONTRIBUTING.md">Contribute</a> ∙ <a href="http://community.dreamfactory.com/">Community Support</a> ∙ <a 
href="https://wiki.dreamfactory.com">Docs</a>
</p>

## Table of Contents

* <a href="#prerequisites">Prerequisites</a>
* <a href="#installation">Installation</a>
* <a href="#app-key">Obtaining the APP Key</a>
* <a href="#documentation">Documentation</a>
* <a href="#commercial">Commercial Licenses</a>
* <a href="#feedback">Feedback</a>

<a name="prerequisites"></a>
## Prerequisites

### Install Helm
- See: [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)

<a name="installation"></a>
## Installing the DreamFactory Helm Chart

### 1) Clone the df-helm repo
`cd ~/repos` (or wherever you want the clone of the repo to be)  
`git clone https://github.com/dreamfactorysoftware/df-helm.git`  
`cd df-helm`

### 2) Edit `values.yaml`
Update the MySQL root password value to a secure password

### 3) Start the pods
`helm install dreamfactory .`

### 4) Ensure pods are running
`kubectl get pods`

You can expect to see 2 DreamFactory pods, 1 MySQL pod for system config storage, and 1 Redis pod for caching.

### 5) Access the Admin UI (Without Ingress)
`kubectl port-forward svc/dreamfactory-dreamfactory 8080:80`
Go to `127.0.0.1:8080` in your browser. It will take some time upon building, but you will be asked to create your first admin user.

### 6) Access the Admin UI (Ingress)
To access DreamFactory through an ingress controller, update the ingress section in your `values.yaml`:

```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: nginx  # or your preferred ingress controller
    annotations:
      # Add any required annotations for your ingress controller
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod  # if using cert-manager
    hosts:
      - your-domain.example.com
    tls: true
```

Then apply the configuration (if dreamfactory has already been installed):
```bash
helm upgrade dreamfactory . -f values.yaml
```

Example configurations for common use cases:

#### Basic HTTP Setup (Existing NGINX Ingress with no TLS)
```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: nginx
    hosts:
      - df.example.com
    tls: false
    pathType: Prefix
```

#### HTTPS with TLS (Existing NGINX Ingress with TLS)
```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: nginx
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-issuer-name
    hosts:
      - df.example.com
    tls: true
    pathType: Prefix
```

#### AWS ALB Setup (AWS Load Balancer Controller needs to be installed) ( Instructions  <a href="https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/deploy/installation/">Here</a>)
```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: alb
    annotations:
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/ssl-redirect: '443'
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
      alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-TLS-1-2-2017-01
      alb.ingress.kubernetes.io/certificate-arn: '' #Certificate needs to exist in AWS Certificate Manager, ALB does not work with letsencrypt
      # ALB also does auto discovery which should be supported out of the box with the ingress definition based on the documentation found at https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/ingress/cert_discovery/
  hosts:
      - df.example.com
    tls: false
    pathType: Prefix
```

#### Contour Ingress Setup
```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: contour
    annotations:
      ingress.kubernetes.io/force-ssl-redirect: "true"
      projectcontour.io/max-connections: "1024"
      projectcontour.io/response-timeout: 30s
      projectcontour.io/websocket-routes: /
    hosts:
      - df.example.com
    tls: true
    pathType: Prefix (could be ImplementationSpecific depends on your setup)
```

#### GCP Ingress Setup (Google Managed Certificates)
```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: gce
    annotations:
      kubernetes.io/ingress.global-static-ip-name: "dreamfactory-ip"  # Optional: if you want a static IP
      # Still need frontend config for SSL redirect
      networking.gke.io/v1beta1.FrontendConfig: "dreamfactory-ssl-redirect"
      networking.gke.io/managed-certificates: "dreamfactory-cert"
    hosts:
      - df.example.com
    tls: false
    pathType: Prefix
```

#### GCP Ingress Setup (LetsEncrypt)
```yaml
dreamfactory:
  ingress:
    enabled: true
    ingressClass: gce
    annotations:
      kubernetes.io/ingress.global-static-ip-name: "dreamfactory-ip"  # Optional: if you want a static IP
      # Still need frontend config for SSL redirect
      networking.gke.io/v1beta1.FrontendConfig: "dreamfactory-ssl-redirect"
      cert-manager.io/cluster-issuer: letsencrypt-issuer-name
    hosts:
      - df.example.com
    tls: true
    pathType: Prefix
```


After applying the configuration:
1. Wait for the ingress to be created: `kubectl get ingress`
2. Ensure your DNS is configured to point to the ingress controller's address
3. Access DreamFactory at the configured host (e.g., https://df.example.com)

**Note**: TLS configuration requires either cert-manager installed in your cluster or manually created TLS secrets.

<a name="app-key"></a>
## Obtaining the APP Key value
After you have spun up your DreamFactory instance, take the APP_KEY value from the `.env` file in `/opt/dreamfactory`. This can be done with the following command:<br>
`kubectl exec -it <pod-name> -- env | grep APP_KEY`

<a name="Uninstalling"></a>
## Uninstalling the pods

`helm uninstall dreamfactory`

This will stop and uninstall all DreamFactory pods.

<a name="documentation"></a>
## Documentation

Learn more about DreamFactory's many features by reading our [Getting Started Guide](http://guide.dreamfactory.com/).
Additional platform documentation can be found on the [DreamFactory wiki](http://wiki.dreamfactory.com).

<a name="commercial"></a>
## Commercial Licenses

In need of official technical support? Desire access to REST API generators for SQL Server, Oracle, SOAP, or mobile
push notifications? Require API limiting and/or auditing? Schedule a demo [with our team](https://www.dreamfactory.com/demo/)!

<a name="feedback"></a>
## Feedback and Contributions

Feedback is welcome on our [forum](http://community.dreamfactory.com/) or in the form of pull requests and/or issues. Contributions should follow the strategy outlined in ["Contributing to a 
project"](http://help.github.com/articles/fork-a-repo#contributing-to-a-project).
