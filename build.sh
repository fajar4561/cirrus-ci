#Set time zone to Moscow
sudo ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo "Cloning dependencies"
git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource -b lime-q-oss kernel && cd kernel
git clone https://github.com/WalkingDead3/AnyKernel3 AnyKernel3
git clone --depth=1 https://github.com/sohamxda7/llvm-stable clang
git clone https://github.com/sohamxda7/llvm-stable -b gcc64 --depth=1 gcc
git clone https://github.com/sohamxda7/llvm-stable -b gcc32  --depth=1 gcc32
echo "Done"
IMAGE=$(pwd)/out/arch/arm64/boot/Image
START=$(date +"%s")
KERNEL_DIR=$(pwd)
PATH="${KERNEL_DIR}/clang/bin:${KERNEL_DIR}/gcc/bin:${KERNEL_DIR}/gcc32/bin:${PATH}"
export KBUILD_BUILD_HOST=WalkingCI
export KBUILD_BUILD_USER="WalkingDead :3"

# Compile plox
function compile() {
    make O=out ARCH=arm64 vendor/citrus-perf_defconfig
    make -j$(nproc --all) O=out \
                    ARCH=arm64 \
                    CC=clang \
                    CLANG_TRIPLE=aarch64-linux-gnu- \
                    CROSS_COMPILE=aarch64-linux-android- \
                    CROSS_COMPILE_ARM32=arm-linux-androideabi-

    if ! [ -a "$IMAGE" ]; then
        exit 1
    fi
    cp out/arch/arm64/boot/Image AnyKernel3
}

function sticker {
    curl -s -X POST "https://api.telegram.org/bot2077617614:AAFOXH87MefDeZQO2LmTLVFAHYyQB8pW05Q/sendSticker" \
        -d sticker="CAADBQADVAADaEQ4KS3kDsr-OWAUFgQ" \
        -d chat_id=@WalkingCI
}

function sendinfo {
    curl -s -X POST "https://api.telegram.org/bot2077617614:AAFOXH87MefDeZQO2LmTLVFAHYyQB8pW05Q/sendMessage" \
        -d chat_id=@WalkingCI \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="<b>• ApocalypseKernel •</b>%0ABuild started on <code>Cirrus-CI</code>%0AFor device <b>Poco M3</b> (citrus)%0Abranch <code>$(git rev-parse --abbrev-ref HEAD)</code>(master)%0AUnder commit <code>$(git log --pretty=format:'"%h : %s"' -1)</code>%0AUsing compiler: <code>Proton clang 12</code>%0AStarted on <code>$(date)</code>%0A<b>Build Status:</b> #AOSP-Alpha"
}

function push() {
    cd AnyKernel3
    ZIP=$(echo *.zip)
	curl -F document=@"${ZIP}" -F 
	"caption=Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s).
    Apocalypse-Kernel for <b>Poco M3 (citrus)</b>" 
	"https://api.telegram.org/bot2077617614:AAFOXH87MefDeZQO2LmTLVFAHYyQB8pW05Q/sendDocument?chat_id=@WalkingCI&parse_mode=Markdown"
}

# Zipping
function zipping() {
    cd AnyKernel3 || exit 1
    zip -r9 Apocalypse-juice-$(date +%Y%m%d-%H%M).zip *
    cd ..
}

sticker
sendinfo
compile
zipping
END=$(date +"%s")
DIFF=$(($END - $START))
push
echo "Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
