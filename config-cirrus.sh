# ccache download
echo "ccache downloader"
df -h
free -h
nproc
cat /etc/os*
env
url=https://anu.inok189.workers.dev/nusantara/ccache.tar.gz
cd /tmp
time aria2c $url -x16 -s50
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz

# Repo
echo "Repo Init/Sync"
mkdir -p /tmp/rom
cd /tmp/rom
repo init -q --no-repo-verify --depth=1 -u https://github.com/Evolution-X/manifest -b elle -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/WalkingProjekt-juice/manifest.git --depth 1 -b EvoX .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# ccache settings
echo "ccache"
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 50G
ccache -o compression=true
ccache -z
