Pod::Spec.new do |spec|
    spec.name = "libcurl-ios"
    spec.summary = "libcurl - the multiprotocol file transfer library"
    spec.homepage = 'https://github.com/cpp-ethereum-ios/curl-ios-build-scripts'
    spec.authors = "The curl authors"
    spec.license = "MIT"

    curl_version = '7.50.3'
    spec.version = "#{curl_version}.2"
    spec.source = { http: "https://curl.haxx.se/download/curl-#{curl_version}.zip" }

    ios_version = '8.0'
    spec.platform = :ios
    spec.ios.deployment_target = "#{ios_version}"

    spec.prepare_command = <<-CMD
    build_for_ios() {
        build_for_architecture iphoneos armv7 arm-apple-darwin
        build_for_architecture iphonesimulator i386 i386-apple-darwin
        build_for_architecture iphoneos arm64 arm-apple-darwin
        build_for_architecture iphonesimulator x86_64 x86_64-apple-darwin
        create_universal_library
        create_universal_headers
    }

    build_for_architecture() {
        PLATFORM=$1
        ARCH=$2
        HOST=$3
        SDKPATH=`xcrun -sdk $PLATFORM --show-sdk-path`
        PREFIX=$(pwd)/build/$ARCH
        ./configure \
        CC=`xcrun -sdk $PLATFORM -find cc` \
        CXX=`xcrun -sdk $PLATFORM -find c++` \
        CPP=`xcrun -sdk $PLATFORM -find cc`" -E" \
        LD=`xcrun -sdk $PLATFORM -find ld` \
        AR=`xcrun -sdk $PLATFORM -find ar` \
        NM=`xcrun -sdk $PLATFORM -find nm` \
        NMEDIT=`xcrun -sdk $PLATFORM -find nmedit` \
        LIBTOOL=`xcrun -sdk $PLATFORM -find libtool` \
        LIPO=`xcrun -sdk $PLATFORM -find lipo` \
        OTOOL=`xcrun -sdk $PLATFORM -find otool` \
        RANLIB=`xcrun -sdk $PLATFORM -find ranlib` \
        STRIP=`xcrun -sdk $PLATFORM -find strip` \
        CPPFLAGS="-arch $ARCH -isysroot $SDKPATH -miphoneos-version-min=#{ios_version}" \
        LDFLAGS="-arch $ARCH -headerpad_max_install_names" \
        --host=$HOST \
        --prefix=$PREFIX \
        --quiet --enable-silent-rules
        xcrun -sdk $PLATFORM make clean --quiet
        xcrun -sdk $PLATFORM make -j 16 install
    }

    create_universal_library() {
        lipo -create -output libcurl.a \
        build/{armv7,arm64,i386,x86_64}/lib/libcurl.a
    }

    create_universal_headers() {
        mkdir -p build/include/curl
        cp -r build/armv7/include/curl/* build/include/curl/
        cp build/armv7/include/curl/curlbuild.h build/include/curl/curlbuild32.h
        cp build/arm64/include/curl/curlbuild.h build/include/curl/curlbuild64.h
        echo '
            #ifdef __LP64__
              #include "curlbuild64.h"
            #else
              #include "curlbuild32.h"
            #endif
        ' > build/include/curl/curlbuild.h
    }

    cd curl-#{curl_version}
    build_for_ios
    CMD

    spec.source_files = "curl-#{curl_version}/build/include/**/*.h"
    spec.header_dir = 'curl'
    spec.ios.vendored_libraries = "curl-#{curl_version}/libcurl.a"
end
