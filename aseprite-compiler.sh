#!/usr/bin/env bash


apt_update(){
    sudo apt update
}

install_aseprite_dependencies(){
    sudo apt install -y \
        git \
        make \
        g++ \
        clang \
        libc++-dev \
        libc++abi-dev \
        cmake \
        ninja-build \
        libx11-dev \
        libxcursor-dev \
        libxi-dev \
        libgl1-mesa-dev \
        libfontconfig1-dev
}

clone_asprite(){
    git clone --recursive https://github.com/aseprite/aseprite.git
    cd aseprite
    git pull
    git submodule update --init --recursive
}

download_skia(){
    curl -Ls "https://github.com/aseprite/skia/releases/download/m102-861e4743af/Skia-Linux-Release-x64-libc++.zip" -o skia.zip
    mkdir -p ~/deps/skia
    unzip skia.zip -d ~/deps/skia
    rm skia.zip
}

compile_aseprite(){
    cd aseprite
    mkdir build
    cd build
    export CC=clang
    export CXX=clang++
    cmake \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_CXX_FLAGS:STRING=-stdlib=libc++ \
      -DCMAKE_EXE_LINKER_FLAGS:STRING=-stdlib=libc++ \
      -DLAF_BACKEND=skia \
      -DSKIA_DIR=$HOME/deps/skia \
      -DSKIA_LIBRARY_DIR=$HOME/deps/skia/out/Release-x64 \
      -DSKIA_LIBRARY=$HOME/deps/skia/out/Release-x64/libskia.a \
      -G Ninja \
      ..
    ninja aseprite
}

create_application(){
    mkdir -p ~/Applications/Aseprite
    mv -v ~/aseprite/build/bin/* ~/Applications/Aseprite
    cd ~/Applications/Aseprite
    curl -LOJs "https://raw.githubusercontent.com/zaemiel/aseprite-compiler/master/aseprite_logo.png"

    desktop_content_file="[Desktop Entry]
Encoding=UTF-8
Name=Aseprite
Exec=$HOME/Applications/Aseprite/aseprite
GenericName=Aseprite
Comment=Pixel Art Painting
Type=Application
Icon=$HOME/Applications/Aseprite/aseprite_logo.png
Categories=Graphics;2DGraphics;RasterGraphics;
Terminal=false
"
    echo "$desktop_content_file" > Aseprite.desktop
    cp Aseprite.desktop ~/.local/share/applications/
}

clean(){
    rm -rf ~/aseprite
    rm -rf ~/deps
}

apt_update
install_aseprite_dependencies
download_skia
clone_asprite
compile_aseprite
create_application
clean
