#!/bin/bash
set -e

FLAGS=$(getopt -a --options hm:p: --long "help,mode:,platform:" -- "$@")

eval set -- "$FLAGS"
while true; do
    case "$1" in
        -m | --mode)              mode=$2; shift 2;;
        -p | --platform)          platform=$2; shift 2;;
        -h | --help)              help="true"; shift 1;;
        --) shift; break;;
    esac
done

# Colours for the messages.
white='\e[1;37m'
green='\e[1;32m'
red='\e[0;31m'

# Common var
currentPath=`pwd`
flutterDockerImage="../../cloud-builders/flutter"

function help {
    echo ""
    echo "Generates local build for Android, Web and Windows. Also can be used to run local web version in release mode."
    echo ""
    echo "Common flags:"
    echo "  -m, --mode                  [Required] Mode for the script, accepted values: 'build' or 'run'"
    echo "  -p, --platform              [Required] Platform name to build or run flutter project."

    exit
}

function checkEnvFile {
    if [ ! -f "${currentPath}/.env" ]; then 
        echo -e "${red}Error: Env file not found." >&2; echo -ne ${white}; exit 1;
    fi
}

function checkKeystoreFile {
    if [ ! -f "${currentPath}/keystore.jks" ]; then 
        echo -e "${red}Error: Keystore file not found." >&2; echo -ne ${white}; exit 1;
    fi
}

function checkPropertiesFile {
    if [ ! -f "${currentPath}/android/key.properties" ]; then 
        echo -e "${red}Error: Properties file not found." >&2; echo -ne ${white}; exit 1;
    fi
}

function checkGoogleServices {
    if [ ! -f "${currentPath}/android/app/google-services.json" ]; then 
        echo -e "${red}Error: Google services file not found." >&2; echo -ne ${white}; exit 1;
    fi
}

function buildRelease {
    case $platform in
        web | android) echo -e "${green}Using platform ${platform} for ${mode}." ;;
        *) echo -e "${red}Error: Platform ${platfrom} not supported for ${mode} is not supported." >&2; echo -ne ${white}; exit 1
    esac
    echo -e "${green}Building app..."; echo -ne ${white}
    # Check local flutter image with 3.3.6 version
    if [[ "$(docker images -q flutter_local:3.3.6 2> /dev/null)" == "" ]]; then
        if [ ! -f "${flutterDockerImage}/Dockerfile" ]; then echo -e "${red}Error: Docker image not found in ${flutterDockerImage}." >&2; echo -ne ${white}; exit 1; fi
        docker build ${flutterDockerImage} -t flutter_local:3.3.6 --build-arg FLUTTER_VERSION=3.3.6
    fi
    # Going to wayat dir to use frontend child dir as a volume
    cd ..
    case $platform in
        android)
            cp frontend/launcher/build-android.yml .
            docker-compose -f build-android.yml up || ( rm ./build-android.yml && exit 1 )
            rm ./build-android.yml
            echo -e "${green}LOCATION: build/app/outputs/flutter-apk/app-release.apk"; echo -ne ${white}
            ;;
        web) 
            cp frontend/launcher/build-web.yml .
            docker-compose -f build-web.yml up || ( rm ./build-web.yml && exit 1 )
            rm ./build-web.yml
            echo -e "${green}LOCATION: build/web"; echo -ne ${white}
            ;;
    esac
    cd $currentPath
    echo -e "${green}Build for ${platform} done."; echo -ne ${white}
}

function runRelease {
    case $platform in
        web) echo -e "${green}Using platform ${platform} for ${mode}."; echo -ne ${white} ;;
        *) echo -e "${red}Error: Platform ${platfrom} not supported for ${mode} is not supported." >&2; echo -ne ${white}; exit 1
    esac
    # Going to wayat dir to use frontend child dir as a volume
    cd ..
    cp frontend/launcher/build-web.yml .
    docker-compose -f build-web.yml up || ( rm ./build-web.yml && exit 1 )
    rm ./build-web.yml
    cd $currentPath
    echo -e "${green}Build for ${platform} done."; echo -ne ${white}
    echo -e "${green}Running app..."; echo -ne ${white}
    docker-compose up
}


if [[ "$help" == "true" ]]; then help; fi


if [[ "$mode" == "" ]]; then echo -e "${red}Error: Mode not provided." >&2; echo -ne ${white}; exit 1; fi
if [[ "$platform" == "" ]]; then echo -e "${red}Error: Platform not provided." >&2; echo -ne ${white}; exit 1; fi


case $platform in
    web | android | desktop) echo -e "${green}Using platform ${platform} for ${mode}."; echo -ne ${white} ;;
    *) echo -e "${red}Error: Platform ${platfrom} not supported for ${mode} is not supported." >&2; echo -ne ${white}; exit 1
esac

checkEnvFile
checkGoogleServices

if [[ "$platform" == "android" ]]; then checkKeystoreFile; checkPropertiesFile; fi

case $mode in
    build) buildRelease ;;
    run) runRelease ;;
    *) echo -e "${red}Error: Mode ${mode} is not supported." >&2; echo -ne ${white}; exit 1
esac
