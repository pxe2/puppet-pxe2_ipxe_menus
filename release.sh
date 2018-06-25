# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=pxe2
# image name
IMAGE=puppet-pxe2_ipxe_menus

# Ensure the repo is up to date
git pull

# Bump Version
docker run --rm -v "$PWD":/app treeder/bump patch
VERSION=`cat VERSION`
set -x
echo "version: $VERSION"
# Bump Version in metadata.json
sed -i '' 's/^.*\"version\"\:.*/\"version\"\:\ \"'"$VERSION"'\",/' metadata.json

# run build

./build.sh -d
# tag it
git add -A
git commit -m "version $VERSION"
git tag -a "$VERSION" -m "version $VERSION"
git push
git push --tags
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
# push it
docker push $USERNAME/$IMAGE
