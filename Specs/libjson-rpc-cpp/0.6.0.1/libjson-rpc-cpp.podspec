Pod::Spec.new do |spec|
  spec.name = "libjson-rpc-cpp"
  spec.summary = "C++ framework for json-rpc (json remote procedure call)"
  spec.homepage = 'https://github.com/cpp-ethereum-ios/libjson-rpc-cpp'
  spec.authors = "libjson-rpc-cpp Authors"
  spec.license = { type: "MIT", file: "LICENSE.txt" }

  spec.version = "0.6.0.1"

  spec.dependency 'JsonCpp', '~> 1.7'
  spec.dependency 'curl', '~> 7.49'
  spec.dependency 'libmicrohttpd-iOS', '~> 0.9'

  spec.source = {
    git: 'https://github.com/cpp-ethereum-ios/libjson-rpc-cpp.git',
    tag: "v#{spec.version}"
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.source_files = "src/jsonrpccpp/**/*.{h,cpp}"
  spec.header_mappings_dir = "src/jsonrpccpp"
  spec.header_dir = 'jsonrpccpp'
  spec.libraries = "c++"

  spec.prepare_command = <<-CMD
    sed \'s/@JSONCPP_INCLUDE_PREFIX@/json/g\' \
      src/jsonrpccpp/common/jsonparser.h.in > src/jsonrpccpp/common/jsonparser.h
  CMD

  spec.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => "$(PODS_ROOT)/#{spec.name}/src"
  }
end
