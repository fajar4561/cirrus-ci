df -h && free -h && nproc && cat /etc/os* && env

cd /tmp/rom
source build/envsetup.sh
lunch rr_citrus-userdebug
mka bacon
cd /tmp
rclone copy /tmp/rom/out/target/product/citrus/RROS*.zip WalkingDead:juice -P
