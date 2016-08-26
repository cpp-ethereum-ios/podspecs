Pod::Spec.new do |spec|
  spec.name = "curl"
  spec.summary = "libcurl - the multiprotocol file transfer library"
  spec.homepage = 'https://github.com/cpp-ethereum-ios/curl-ios-build-scripts'
  spec.authors = "The curl authors"
  spec.license = "MIT"

  spec.version = "7.49.1.1"

  spec.source = {
    git: 'https://github.com/cpp-ethereum-ios/curl-ios-build-scripts.git',
    tag: "v#{spec.version}"
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.prepare_command = <<-CMD
    ./build_curl --archs i386,x86_64,armv7,arm64 --osx-sdk-version none

    mkdir -p curl/ios-universal

    cp -r curl/ios-dev/include curl/ios-universal/include
    cp curl/ios-dev/include/curlbuild.h curl/ios-universal/include/curlbuild32.h
    cp curl/ios64-dev/include/curlbuild.h curl/ios-universal/include/curlbuild64.h

    cat > curl/ios-universal/include/curlbuild.h <<'EOF'
      #ifdef __LP64__
        #include "curlbuild64.h"
      #else
        #include "curlbuild32.h"
      #endif
    EOF

    mkdir -p curl/ios-universal/lib
    cp curl/ios-dev/lib/libcurl.a curl/ios-universal/lib
  CMD

  spec.source_files = "curl/ios-universal/include/**.h"
  spec.header_dir = "curl"
  spec.ios.vendored_libraries = "curl/ios-universal/lib/libcurl.a"
end
