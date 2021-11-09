cd /tmp/rom
source build/envsetup.sh
lunch evolution_juice-userdebug
make evolution
cd /tmp
rclone copy /tmp/rom/out/target/product/juice/Evolution*.zip WalkingDead:juice -P
