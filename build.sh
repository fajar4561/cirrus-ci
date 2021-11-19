df -h
free -h
nproc
cat /etc/os*
env

cd /tmp
time aria2c $url -x16 -s50
time tar xf ccache.tar.gz
rm -rf ccache.tar.gz

export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 20G
ccache -o compression=true
ccache -z

cd /tmp/rom
source build/envsetup.sh
lunch lineage_juice-userdebug
make bacon -j$(nproc --all)
cd /tmp
rclone copy /tmp/rom/out/target/product/juice/Lineage*.zip WalkingDead:juice -P
time rclone copy ccache.tar.gz WalkingDead:juice -P
