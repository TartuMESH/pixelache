# Pixelache mesh networking workshop in Helsinki Sept 26th 2015

These are instructions for:

* http://livingspaces.pixelache.ac/events/mesh-networking-workshop

## Preparing Raspberry Pi 1/2 with Raspbian Wheezy for B.A.T.M.A.N

### Update everything and upgrade to Debian Jessie (takes **a lot** of time)

```console
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo sed -i~ -e "s/wheezy/jessie/g" /etc/apt/sources.list
sudo sed -i~ -e "s/wheezy/jessie/g" /etc/apt/sources.list.d/raspi.list
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo rpi-update
sudo reboot
```

### Install B.A.T.M.A.N with its various prerequisites

```console
sudo apt-get install gcc-4.8 g++-4.8 libncurses5-dev
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50
sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source
sudo chmod +x /usr/bin/rpi-source
/usr/bin/rpi-source
wget http://downloads.open-mesh.org/batman/stable/sources/batctl/batctl-2015.1.tar.gz
wget http://downloads.open-mesh.org/batman/stable/sources/alfred/alfred-2015.1.tar.gz
wget http://downloads.open-mesh.org/batman/stable/sources/batman-adv/batman-adv-2015.1.tar.gz
tar xzvf alfred-2015.1.tar.gz
tar xzvf batctl-2015.1.tar.gz
tar xzvf batman-adv-2015.1.tar.gz
sudo apt-get install libnl-3-dev libcap-dev libgps-dev
cd batman-adv-2015.1
make
sudo make install
cd ../batctl-2015.1
make
sudo make install
cd ../alfred-2015.1
make
sudo make install
sudo reboot
```

### Initialize basic mesh network (plug in mesh compatible USB wifi dongle)

```console
sudo apt-get install iw bridge-utils
git clone https://github.com/TartuMESH/pixelache.git
cd pixelache
chmod +x pixelme.sh
sudo ./pixelme.sh wlan0
```
