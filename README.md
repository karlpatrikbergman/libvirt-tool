# Libvirt Examples
## libvirt - Virtualization API
Libvirt is a toolkit to interact with the virtualization of recent versions of Linux. libvirt supports KVM/QEMU and many others (as Virtualbox, Xen, LXC for example). These software pieces include an API library, a daemon (libvirtd), and a command line utility (virsh).
 
**virsh**  
virsh is a command line interface that can be used to create, destroy, stop start and edit virtual machines and configure the virtual environment (such as virtual networks etc)
 
**virt-install**  
virt-install is a command line tool that simplifies the process of creating a virtual machine.
 
**virt-manager**  
virt-manager is a GUI that can be used to create, destroy, stop, start and edit virtual machines and configure the virtual environment (such as virtual networks etc)

### Terminology
To avoid ambiguity about the terms used, here are the definitions for some of the specific concepts used in libvirt documentation:

* A Node is a single physical machine
* An Hypervisor is a layer of software allowing to virtualize a node in a set of virtual machines with possibly different configurations than the node itself
* A Domain is an instance of an operating system (or subsystem in the case of container virtualization) running on a virtualized machine provided by the hypervisor
    * A Domain is an instance of an operating system running on a virtualized machine. A guest domain can refer to either a running virtual machine or a configuration which can be used to launch a virtual machine.

![alt text](https://libvirt.org/node.gif "")

&nbsp;
***
&nbsp;

# Remote host is tnm-vm7
## Create vm on tnm-vm7 (physical machine)
To create a new domain/vm on tnm-vm7, run function `create_domain_on_tnm_vm7` with name of new domain/vm as argument
```shell
$ create_domain_on_tnm_vm7 <domain-name>
```
&nbsp;

## Get ip address of vm on tnm-vm7
To get the ip number of a domain/vm running on tnm-vm7 (physical machine), run function `get_ip_address_of_vm_on_tnm_vm7` with name of domain/vm as argument
```shell
$ get_ip_address_of_vm_on_tnm_vm7 <domain-name>
```
&nbsp;

## Delete vm on tnm-vm7
To delete a domain/vm running on tnm-vm7 (physical machine), run function `delete_domain_on_tnm_vm7` with name of domain/vm as argument
```shell
$ delete_domain_on_tnm_vm7 <domain-name>
```
&nbsp;

# Remote host specified with arguments
## Create vm on remote host (using clone)
Run bash function `create_domain_remote` with user@host of host running hypervisor, name of domain used as clone source 
(must exist in images directory on remote host), name of new domain and remote images directory as arguments.
Example:
```shell
$ create_domain_remote root@tnm-vm7 centos7_clone_source centos-jodo /var/lib/libvirt/images
```
&nbsp;

## Get ip address of vm running on remote host
Get ip address of vm on remote host by running bash function `get_ip_address_of_vm` with user@host of host running hypervisor,
domain name, ip address of gateway and host bridge as arguments. 
"virtual bridge". Note that arp must be installed. 
```shell
$ get_ip_address_of_vm root@tnm-vm7 centos-jodo 172.16.15.0/24 br0
```
## Delete vm on remote host
Run bash function `delete_domain_remote` with user@host of host running hypervisor, domain name and remote images directory as arguments.
```shell
$ delete_domain_remote root@tnm-vm7 centos-jodo /var/lib/libvirt/images
```
&nbsp;

***
## virsh
#### Connect to local host and list vm:s
```shell
$  virsh -c qemu:///system
virsh # list
```
#### Connect to tnm-vm7 and list vm:s
```shell
$ virsh -c qemu+ssh://root@tnm-vm7/system
virsh # list
         Id    Name                           State
        ----------------------------------------------------
         1     centos-kini                    running
         2     centos-stos                    running
...
```
