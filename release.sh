# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=pxe2
# image name
IMAGE=ipxe-menu-builder

# Ensure the repo is up to date
git pull

# Bump Version
docker run --rm -v "$PWD":/app treeder/bump patch
VERSION=`cat VERSION`
set -x
echo "version: $VERSION"
# Bump Version in metadata.json
sed -i 's/^.*\"version\"\:.*/\ \ \"version\"\:\ \"'"$VERSION"'\",/' metadata.json

# run build

./build.sh
# tag it
git add -A
echo -n "**** COMMITING VERSION:$VERSION $BASE TO $USER/$IMAGE.git ****"
git commit -m "Build Logs for version $VERSION"
echo -n "**** TAGGING VERSION:$VERSION $BASE TO $USER/$IMAGE.git ****"
git tag -a "$VERSION" -m "version $VERSION"
echo -n "**** PUSHING VERSION:$VERSION $BASE TO $USER/$IMAGE.git ****"
git push
git push --tags
echo -n "**** DOCKER IMAGE TAGGING VERSION:$VERSION $BASE TO $USER/$IMAGE:$VERSION (alpinelinux) ****"
docker tag $USERNAME/$IMAGE $USERNAME/$IMAGE:$VERSION

# push it
echo -n "**** PUSHING DOCKER IMAGE VERSION:$VERSION $BASE TO $USER/$IMAGE:$VERSION (alpinelinux)[hub.docker.com]****"
docker push $USERNAME/$IMAGE
