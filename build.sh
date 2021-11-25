set -e
set -x

df -h && free -h && nproc && cat /etc/os* && env

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

rclone copy /tmp/hentaiOS/out/target/product/juice/Weeb*.zip WalkingDead:juice -P
rclone copy ccache.tar.gz WalkingDead:juice -P
