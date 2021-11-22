df -h && free -h && nproc && cat /etc/os* && env

url=https://roms.apon77.workers.dev/ccache/ci2/ccache.tar.gz

cd /tmp
time aria2c $url -x16 -s50
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz

cd /tmp/rom
source build/envsetup.sh
lunch rr_citrus-userdebug
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 20G
ccache -o compression=true
ccache -z
mka bacon -j$(nproc --all)
cd /tmp
rclone copy /tmp/rom/out/target/product/citrus/RROS*.zip WalkingDead:juice -P
