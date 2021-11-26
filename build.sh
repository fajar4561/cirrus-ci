set -e
set -x

df -h && free -h && nproc && cat /etc/os* && env

cd /tmp/hentaiOS
git clone --depth=1 $repo_device -b $device_branch $path_device
git clone --depth=1 $repo_kernel -b $kernel_branch $path_kernel
git clone --depth=1 $repo_vendor -b $vendor_branch $path_vendor
git clone --depth=1 $repo_clang -b $clang_branch $path_clang
rm -rf device/generic/opengl-transport

export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
ccache -M 8G
ccache -z

cd /tmp/hentaiOS
source build/envsetup.sh
lunch hentai_juice-userdebug
make otapackage
cd /tmp
com () 
{ 
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1

rclone copy /tmp/hentaiOS/out/target/product/juice/*.zip WalkingDead:juice -P
rclone copy ccache.tar.gz WalkingDead:juice -P
