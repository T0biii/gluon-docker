[ -z "$FFMUC_REPO" ] && FFMUC_REPO=https://github.com/freifunkMUC/site-ffm.git || echo "$FFMUC_REPO"
[ -z "$FFMUC_VERSION" ] && FFMUC_VERSION=experimental || echo "$FFMUC_VERSION"

git clone $FFMUC_REPO site-ffm
cd site-ffm
git checkout -b patched && git checkout $FFMUC_VERSION
make
