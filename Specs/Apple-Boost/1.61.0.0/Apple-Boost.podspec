Pod::Spec.new do |spec|
  spec.name = "Apple-Boost"
  spec.summary = "Boost C++ Libraries"
  spec.homepage = 'https://github.com/markspanbroek/Apple-Boost-BuildScript'
  spec.authors = "Boost Authors"
  spec.license = "Boost License"

  boost_version = '1.61.0'
  spec.version = "#{boost_version}.0"

  spec.source = {
    git: 'https://github.com/markspanbroek/Apple-Boost-BuildScript.git',
    tag: "v#{spec.version}"
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.prepare_command = './boost.sh -ios'

  spec.ios.vendored_frameworks = "build/boost/#{boost_version}/ios/framework/boost.framework"
end
