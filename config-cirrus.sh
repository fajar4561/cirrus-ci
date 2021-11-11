# ccache download
echo "ccache downloader"
df -h
free -h
nproc
cat /etc/os*
env

# Repo
echo "Repo Init/Sync"
mkdir -p /tmp/rom
cd /tmp/rom
repo init -q --no-repo-verify --depth=1 -u git://github.com/LineageOS/android.git -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/WalkingDead3/manifest.git --depth 1 -b lineage-17.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# ccache settings
echo "ccache"
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 50G
ccache -o compression=true
ccache -z
