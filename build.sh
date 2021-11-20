df -h
free -h
nproc
cat /etc/os*
env

git clone $repo_device --depth 1 -b 11.0 $path_device
git clone $repo_vendor --depth 1 -b 11 $path_vendor
git clone $repo_kernel --depth 1 -b 11.0 $path_kernel
git clone $repo_clang --depth 1 -b master $path_clang

cd /tmp/rom
source build/envsetup.sh
lunch hentai_juice-userdebug
make otapackage -j$(nproc --all)
cd /tmp
rclone copy /tmp/rom/out/target/product/juice/hentai*.zip WalkingDead:juice -P
