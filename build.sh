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

repo init --depth=1 --no-repo-verify -u https://github.com/ResurrectionRemix/platform_manifest.git -b Q
git clone https://github.com/WalkingDead3/manifest.git --depth 1 -b RR .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

cd /tmp/rom
source build/envsetup.sh
lunch rr_citrus-userdebug
make bacon
cd /tmp
rclone copy /tmp/rom/out/target/product/citrus/RROS*.zip WalkingDead:juice -P
time rclone copy ccache.tar.gz WalkingDead:juice -P
