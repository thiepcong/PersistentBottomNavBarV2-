if ! [[ -z $1 ]]; then
    explicit_version=true;
    if [ "$1" = "major" ]; then
        explicit_version=false; fi
    if [ "$1" = "minor" ]; then
        explicit_version=false; fi
    if [ "$1" = "patch" ]; then
        explicit_version=false; fi
    if [ "$explicit_version" = "true" ]; then
        cider version $1;
    else
        cider bump $1;
    fi
    flutter pub get;

    new_version=$(cider version);

    echo "New version: $new_version";
    echo "Changes to release:";
    cider describe;
    cider release;
    git commit pubspec.yaml CHANGELOG.md example/pubspec.lock -m "Version $new_version";
    git tag -a v$new_version -m "Version $new_version";
    git push;
    git push --tags;
    exit 0;
else
    echo "Usage: $0 version number or major, minor, patch";
    exit 1;
fi
