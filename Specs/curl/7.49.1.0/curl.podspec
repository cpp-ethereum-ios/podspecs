Pod::Spec.new do |spec|
  spec.name = "curl"
  spec.summary = "libcurl - the multiprotocol file transfer library"
  spec.homepage = 'https://github.com/cpp-ethereum-ios/curl-ios-build-scripts'
  spec.authors = "The curl authors"
  spec.license = "MIT"

  spec.version = "7.49.1.0"

  spec.source = {
    git: 'https://github.com/cpp-ethereum-ios/curl-ios-build-scripts.git',
    tag: "v#{spec.version}"
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.prepare_command = <<-CMD
    ./build_curl --archs i386,x86_64,armv7,arm64 --osx-sdk-version none
  CMD

  spec.source_files = "curl/ios-dev/include/**.h"
  spec.header_dir = "curl"
  spec.ios.vendored_libraries = "curl/ios-dev/lib/libcurl.a"
end
