function gen_git_version () {
    if [ "$1" == "" ]
    then
        echo "Missing parameters for gen_git_version()"
        exit 10
    fi

    REPO_DIR="$1"
    if [ ! -d "$REPO_DIR" ]
    then
        echo "Missing directory: ${REPO_DIR}"
        exit 11
    fi

    POSTFIX=""
    if [ "$2" != "" ]
    then
        POSTFIX="$2"
    fi

    pushd "$REPO_DIR" >/dev/null

    PREFIX="4.0.0"
    STAMP=$(date -d $(git log -1 --date=short --format="%cd") +"%Y%m%d")
    COMMIT=$(git rev-parse --short HEAD)
    VERSION="${PREFIX}+git${STAMP}+${COMMIT}-0"
    if [ "$POSTFIX" != "" ]
    then
        VERSION="${VERSION}+${POSTFIX}"
    fi

    popd >/dev/null

    if [ "$VERSION" == "" ]
    then
        echo "Version generation failed!"
        exit 24
    fi

    echo "$VERSION"
}

function git_switch_branch () {

    REPO_DIR="$1"
    REPO_BRANCH="$2"

    if [[ "$1" == "" || "$2" == "" ]]
    then
        echo "Missing parameters for git_switch_branch()"
        exit 10
    fi

    if [ ! -d "$REPO_DIR" ]
    then
        echo "Missing directory: ${REPO_DIR}"
        exit 11
    fi

    pushd "$REPO_DIR" >/dev/null
    git reset --hard
    git fetch
    git checkout "$REPO_BRANCH"
    popd >/dev/null
}

function check_build_conf () {

    if [ ! -f "build-config" ]
    then
        echo "Missing build-config ! Please create one by copying the provided .dist file, and editing it as necessary"
        echo
        echo "  cp build-config.dist build-conf && \$EDITOR build-config"
        echo
        exit 36
    fi

    for var in SIMH_COMMIT BLINKENBONE_COMMIT DEB_AUTHOR_EMAIL DEB_AUTHOR_NAME DEB_VERSION_TAG
    do
        if [ "${!var}" = "" ]
        then
            echo "Missing build configuration setting: ${var}"
            exit 37
        fi
    done
}

function append_version () {
    REPO_DIR="$1"
    NEW_VERSION="$2"

    if [[ "$1" == "" || "$2" == "" ]]
    then
        echo "Missing parameters for append_version()"
        exit 10
    fi

    if [ ! -d "$REPO_DIR" ]
    then
        echo "Missing directory: ${REPO_DIR}"
        exit 11
    fi

    if [[ "$DEB_AUTHOR_NAME" == "" || "$DEB_AUTHOR_NAME" == "" ]]
    then
        echo "Author name/email not configured! Please edit build-conf"
        exit 12
    fi

    DEBFULLNAME="$DEB_AUTHOR_NAME"
    DEBEMAIL="$DEB_AUTHOR_EMAIL"

    pushd "$REPO_DIR" >/dev/null
    dch -v "$NEW_VERSION" \
        --preserve \
        --distribution unstable \
        "Automatically generated unofficial package"
    popd >/dev/null
}

function build_deb () {
    BUILD_DIR="$1"

    if [ "$1" == "" ]
    then
        echo "Missing parameters for build_deb()"
        exit 10
    fi

    if [ ! -d "$BUILD_DIR" ]
    then
        echo "Missing directory: ${BUILD_DIR}"
        exit 11
    fi

    pushd "$BUILD_DIR" >/dev/null
    if [ "$SKIP_CLEAN" == "1" ]
    then
        dpkg-buildpackage -nc --no-sign -b -rfakeroot
    else
        dpkg-buildpackage --no-sign -b -rfakeroot
    fi
    popd >/dev/null
}

function start_timer () {
    SECONDS=0
}

# https://stackoverflow.com/a/8903280
function stop_timer () {
    duration=$SECONDS
    echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
}

function check_prerequisities () {

    for package in "$@"
    do
        if ! dpkg -s "$package" >/dev/null
        then
            echo "Required package missing: ${package}"
            echo "Install all the required packages with:"
            echo
            echo "  sudo apt-get update && sudo apt-get install $@"
            echo
            exit 46
        fi
    done
}
