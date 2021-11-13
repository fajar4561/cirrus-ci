df -h
free -h
nproc
cat /etc/os*
env

export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 50G
ccache -o compression=true
ccache -z

mkdir -p /tmp/rom
cd /tmp/rom
repo init -q --no-repo-verify --depth=1 -u git://github.com/LineageOS/android.git -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/WalkingDead3/device_xiaomi_citrus -b lerish device/xiaomi/citrus
git clone https://github.com/WalkingDead3/vendor_xiaomi_citrus -b los17 vendor/xiaomi/citrus

cd /tmp/rom
source build/envsetup.sh
lunch lineage_citrus-userdebug
make bacon
cd /tmp
rclone copy /tmp/rom/out/target/product/citrus/Lineage*.zip WalkingDead:juice -P
time rclone copy ccache.tar.gz WalkingDead:juice -P
