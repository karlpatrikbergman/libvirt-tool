# Libvirt Examples
## libvirt - Virtualization API
Libvirt is a toolkit to interact with the virtualization of recent versions of Linux. libvirt supports KVM/QEMU and many others (as Virtualbox, Xen, LXC for example). These software pieces include an API library, a daemon (libvirtd), and a command line utility (virsh).
 
**virsh**  
virsh is a command line interface that can be used to create, destroy, stop start and edit virtual machines and configure the virtual environment (such as virtual networks etc)
 
**virt-install**  
virt-install is a command line tool that simplifies the process of creating a virtual machine.
 
**virt-manager**  
virt-manager is a GUI that can be used to create, destroy, stop, start and edit virtual machines and configure the virtual environment (such as virtual networks etc)

**domain**  
A domain is an instance of an operating system running on a virtualized machine. A guest domain can refer to either a running virtual machine or a configuration which can be used to launch a virtual machine.

&nbsp;
***

## Create vm on local host (using copy) 
Run bash script with the name of the vm as input argument:
```shell
$ ./create_domain_local_copy.sh foo
```
Get ip address of vm. Note that arp must be installed. 
```shell
$ sudo ./get_domain_ip_address_local.sh foo  
```
&nbsp;
*** 

## Create vm on local host (using clone)
This version is somewhat faster.  
Run bash script with the name of the vm as input argument:
```shell
$ ./create_domain_local_clone.sh bar
```
Get ip address of vm, see above  

&nbsp;
***

## Create vm on remote host (using clone)
Run bash script with remote host connection, domain name and remote images directory as arguments.
```shell
$ ./create_domain_remote_clone.sh qemu+ssh://root@tnm-vm7/system pabe_test /var/lib/libvirt/images
```
Get ip address of vm on remote host with arguments "remote host connection", "domain name", "subnetwork" and 
"virtual bridge". Note that arp must be installed. 
```shell
$ ./get_domain_ip_address.sh qemu+ssh://root@tnm-vm7/system pabe_test 172.16.15.0/24 br0
```

&nbsp;
***

## Create vm on remote host (using copy)
Run bash script with remote host connection, domain name and remote images directory as arguments.
```shell
$ ./create_domain_remote_copy.sh qemu+ssh://root@tnm-vm7/system pabe_test /var/lib/libvirt/images
```

&nbsp;
***
virsh
## Connect to local host and list vm:s
```shell
$  virsh -c qemu:///system
virsh # list
```
## Connect to tnm-vm7 and list vm:s
```shell
$ virsh -c qemu+ssh://root@tnm-vm7/system
virsh # list
         Id    Name                           State
        ----------------------------------------------------
         1     centos-kini                    running
         2     centos-stos                    running
...
```
