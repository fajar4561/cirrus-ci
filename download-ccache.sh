df -h
free -h
nproc
cat /etc/os*
env
url=https://roms.apon77.workers.dev/ccache/ci3/ccache.tar.gz
cd /tmp
time aria2c $url -x16 -s50
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz
