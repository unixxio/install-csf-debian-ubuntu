# Install CSF Firewall on Debian or Ubuntu

This script will help you install CSF Firewall on Debian or Ubuntu. It will:

* Ask which ports to open (default 80/443 for HTTP and HTTPS)
* Disable testing mode
* Remove comments from `/etc/csf/csf.conf` to increase readability

#### Step 1 - Download and install script

```
wget -q https://raw.githubusercontent.com/unixxio/install-csf-debian-ubuntu/master/install_csf.sh
```

#### Step 2 - Execute install script

```
sudo chmod +x install_csf.sh && sudo ./install_csf.sh
```

#### Tested on

* Debian 8 Jessie
* Debian 9 Stretch
