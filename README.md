# README

This project is by now means ready for public consumption. For the time being, its just a ragtag collection of scripts, wrappers, ansible and cruft to help me organize all the material I've accumulated that revolves around bootstrapping a Kubernetes cluster on ARM64-based Raspberry Pi's.

Fork it, use it or read it at the risk of your own peril.

Having said that, if you wish to help, please fork and open a pull request with a good description of what you are contributing.

Cheers!

## BASIC WORKFLOW COMMANDS

```bash
### Download Ubuntu images images

$ make init

### Burn the OS to the SD card

$ make burn

### Clean up

$ make cleanup

### Cluster node configuration
#### Configure all nodes

$ make config-k8s

#### Configure only the backplane / controller node

$ make config-k8s-master

#### Configure only worker nodes

$ make config-k8s-nodes

#### Only generate and retrieve a new _join cluster_ kubeadmin string

$ make config-k8s-get-join-command
```

## SOURCE DOCUMENTATION

- [How to install Ubuntu Server on your Raspberry Pi](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview)
- [Build a Kubernetes cluster with the Raspberry Pi](https://opensource.com/article/20/6/kubernetes-raspberry-pi)
- [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [MetalLB](https://metallb.universe.tf/)

## DIRECTORY STRUCTURE
For the most part, if you are familiar with Ansible, this should make sense --except for the fact that I am shoving roles and plays into the same repo. What? Don't expect pretty.

```
.
├── ansible
│   ├── 00-base
│   │   ├── defaults
│   │   ├── files
│   │   ├── handlers
│   │   ├── meta
│   │   ├── tasks
│   │   ├── templates
│   │   ├── tests
│   │   └── vars
│   └── 01-kubernetes
│       ├── defaults
│       ├── files
│       ├── handlers
│       ├── meta
│       ├── tasks
│       ├── templates
│       ├── tests
│       └── vars
└── kubernetes
```

## NOTES

- I am trying to wrap as much of the bash cruft into a makefile. For better or for worse, if you are curious, dig into the _Makefile_ at the root of the project repo to see what each thing is up to.
