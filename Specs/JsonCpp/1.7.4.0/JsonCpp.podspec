Pod::Spec.new do |spec|
  spec.name = "JsonCpp"
  spec.summary = "A C++ library for interacting with JSON"
  spec.homepage = 'https://github.com/markspanbroek/jsoncpp'
  spec.authors = "JsonCpp Authors"
  spec.license = { type: "MIT", file: "LICENSE" }

  spec.version = "1.7.4.0"

  spec.source = {
    git: 'https://github.com/markspanbroek/jsoncpp.git',
    tag: "#{spec.version}"
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.source_files = "src/lib_json/*.{h,cpp}", "include/json/*.h"
  spec.preserve_paths = "src/lib_json/*.inl"
  spec.public_header_files = "include/json/*.h"
  spec.header_dir = "json"
  spec.libraries = "c++"
end
