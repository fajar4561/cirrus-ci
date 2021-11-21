df -h
free -h
nproc
cat /etc/os*
env


cd /tmp/rom
source build/envsetup.sh
lunch hentai_juice-userdebug
export SELINUX_IGNORE_NEVERALLOWS := true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
make otapackage -j$(nproc --all)
cd /tmp
rclone copy /tmp/rom/out/target/product/juice/hentai*.zip WalkingDead:juice -P
