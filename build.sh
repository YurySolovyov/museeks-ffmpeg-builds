shopt -s extglob
make clean

BUILD_ROOT=$(pwd)
CONFIGURE_ROOT=$(pwd)/src/configure

function build_for_platform() {
  local dir=$1
  local os=$2
  local arch=$3

  rm -rf $dir
  mkdir $dir
  cd $dir

  $CONFIGURE_ROOT \
    --arch=$arch \
    --target-os=$os \
    --enable-small \
    --enable-cross-compile \
    --disable-ffserver \
    --disable-ffprobe \
    --disable-doc \
    --disable-htmlpages \
    --disable-manpages \
    --disable-podpages \
    --disable-txtpages \
    --disable-avdevice \
    --disable-swscale \
    --disable-swscale-alpha \
    --disable-postproc \
    --disable-dxva2 \
    --disable-vaapi \
    --disable-vda \
    --disable-vdpau \
    --disable-pixelutils \
    --disable-devices \
    --disable-filters \
    --disable-hwaccels \
    --disable-bsfs \
    --disable-muxers \
    --disable-decoders \
    --disable-demuxers \
    --disable-encoders \
    --disable-parsers \
    --disable-protocols \
    --enable-protocol="file,pipe" \
    --enable-muxer="wav" \
    --enable-demuxer="aac,mp3,mov,flac,asf" \
    --enable-decoder="aac,mp3,mp4,m4a,flac,ogg,3gpp,wav,wma*" \
    --enable-encoder="pcm_s16le" \
    --enable-filter="aresample" \
    --enable-avresample

  make -j8

  ./ffmpeg -v 0 -formats || ./ffmpeg.exe -v 0 -formats
  rm -rf !(ffmpeg|ffmpeg.exe)
  ls -lh ffmpeg*
  cd $BUILD_ROOT
}

build_for_platform "out-linux" "linux" "x86_64"
build_for_platform "out-win" "win32" "x86_64"
# build_for_platform "out-macos" "darwin" "x86_64"
