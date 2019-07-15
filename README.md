# Zero to JupyterHub with Kubernetes

[![Build Status](https://travis-ci.org/jupyterhub/zero-to-jupyterhub-k8s.svg?branch=master)](https://travis-ci.org/jupyterhub/zero-to-jupyterhub-k8s)
[![Documentation Status](https://readthedocs.org/projects/zero-to-jupyterhub/badge/?version=latest)](https://zero-to-jupyterhub.readthedocs.io/en/latest/?badge=latest)
[![Latest stable release](https://img.shields.io/badge/dynamic/json.svg?label=stable&url=https://jupyterhub.github.io/helm-chart/info.json&query=$.jupyterhub.stable&colorB=orange)](https://jupyterhub.github.io/helm-chart/)
[![Latest development release](https://img.shields.io/badge/dynamic/json.svg?label=dev&url=https://jupyterhub.github.io/helm-chart/info.json&query=$.jupyterhub.latest&colorB=orange)](https://jupyterhub.github.io/helm-chart/)
[![GitHub](https://img.shields.io/badge/issue_tracking-github-blue.svg)](https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues)
[![Discourse](https://img.shields.io/badge/help_forum-discourse-blue.svg)](https://discourse.jupyter.org/c/jupyterhub/z2jh-k8s)
[![Gitter](https://img.shields.io/badge/social_chat-gitter-blue.svg)](https://gitter.im/jupyterhub/jupyterhub)


This repo contains a *Helm chart* for JupyterHub and a guide to use it. Together
they allow you to make a JupyterHub available to a very large group of users
such as the staff and students of a university.

## The guide

The [Zero to JupyterHub with Kubernetes guide](https://z2jh.jupyter.org)
provides user-friendly steps to _deploy_
[JupyterHub](https://github.com/jupyterhub/jupyterhub) on a cloud using
[Kubernetes](https://kubernetes.io/) and [Helm](https://helm.sh/).

The guide is complemented well by the [documentation for JupyterHub](https://jupyterhub.readthedocs.io).

## The Helm chart

The JupyterHub Helm chart lets a user create a reproducible and maintainable
deployment of JupyterHub on a Kubernetes cluster in a cloud environment. The
released charts are made available in our [Helm chart
repository](https://jupyterhub.github.io/helm-chart).

## History

Much of the initial groundwork for this documentation is information learned
from the successful use of JupyterHub and Kubernetes at UC Berkeley in their
[Data 8](http://data8.org/) program.

![](doc/source/_static/images/data8_audience.jpg)

## Acknowledgements

Thank you to the following contributors:

- Aaron Culich
- Carol Willing
- Chris Holdgraf
- Erik Sundell
- Ryan Lovett
- Yuvi Panda

Future contributors are encouraged to add themselves to this README file too.

## Licensing

This repository is dual licensed under the Apache2 (to match the upstream
Kubernetes [charts](https://github.com/helm/charts) repository) and
3-clause BSD (to match the rest of Project Jupyter repositories) licenses. See
the `LICENSE` file for more information!

## Deployment of the chart using an ibox
An ibox-iscsi storage class needs to be deployed to the k8s cluster.  See https://git.infinidat.com/dohlemacher/infinidat-k8s-installer/blob/PSDEV-235/AddHelmChart/helm/infinidat-provisioner/iboxProvisionerHelmDocs.ipynb

### Deploy the chart
- `cd jupyterhub/`
- A kubeconfig file is required for our k8s cluster.
- Execute one of:
    - `helm install --namespace jup --name jupyterhub --values values.yaml --values config.yaml .`
    - `helm upgrade --install jupyter --values values.yaml --values config.yaml .`
- `kubectl -n jup get all`
    - Monitor the jup namespace and verify jupyterhub is deployed properly.

### Access from your laptop
Using the nodePort, visit any one of of the virtual machines (nodes) hosting k8s (recommended):
- Visit http://172.31.78.164:32222
- Visit http://172.31.78.165:32222
- Visit http://172.31.78.166:32222

Using port-forwarding (not recommended):
- `kubectl port-forward -n jup "proxy-NNN name" 9000:8000`
- Visit http://127.0.0.1:9000
    - If necessary, you may chose another local port rather than 9000 that is greater than 5000.

Create a notebook. Click the `new button` and select Python3.

Open a terminal. Click the `new button` and select terminal.

### Jupyterhub teardown
- `helm delete --purge jupyterhub`
- There may be user pods running. These have names such as "pod/jupyter-<user>". For each:
    - `kubectl -n jup delete pod <user pod name>`
- Delete the namespace:
    - `kubectl delete namespace jup`
- To truly cleanup, with loss of user env data, delete PVCs and PVs associated with JH.
