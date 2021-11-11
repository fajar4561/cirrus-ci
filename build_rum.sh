cd /tmp/rom
source build/envsetup.sh
lunch lineage_citrus-userdebug
make bacon
cd /tmp
rclone copy /tmp/rom/out/target/product/citrus/Lineage*.zip WalkingDead:juice -P
