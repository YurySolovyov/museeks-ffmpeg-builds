VERSION=`cat version.md`
BRANCH="n$VERSION"
git clone --branch $BRANCH https://github.com/FFmpeg/FFmpeg.git src
