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
 
---

## Create vm on local host (using copy)
Run bash script with the name of the vm as input argument:
```shell
$ ./create_domain_local_copy.sh foo
```

