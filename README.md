# packer-centos-vsphere
Packer scripts for building CentOS templates on VMware vSphere (Requires vCenter)

# CentOS 7

```bash
packer build \
    -var-file=./variables/centos7.example.pkrvars.hcl \
    -var-file=./variables/vcenter.example.pkrvars.hcl \
    .
```

# CentOS 8

```bash
packer build \
    -var-file=./variables/centos8.example.pkrvars.hcl \
    -var-file=./variables/vcenter.example.pkrvars.hcl \
    .
```