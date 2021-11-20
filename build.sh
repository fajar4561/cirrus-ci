df -h
free -h
nproc
cat /etc/os*
env

export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 15G
ccache -o compression=true
ccache -z

cd /tmp/rom
source build/envsetup.sh
lunch hentai_juice-userdebug
make otapackage -j$(nproc --all)
cd /tmp
rclone copy /tmp/rom/out/target/product/juice/hentai*.zip WalkingDead:juice -P
time rclone copy ccache.tar.gz WalkingDead:juice -P
