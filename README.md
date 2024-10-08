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

### 5) Expose the pod in the browser
`kubectl port-forward svc/dreamfactory-dreamfactory 8080:80`

### 6) Access the Admin UI
Go to `127.0.0.1:8080` in your browser. It will take some time upon building, but you will be asked to create your first admin user.

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
