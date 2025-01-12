package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'
Pod::Spec.new do |s|
  s.name         = "waas-sdk-react-native"
  s.version      = package["ALPHA"]
  s.summary      = package["WAAS (WALLY)"]
  s.homepage     = package["homepage"]
  s.license      = package["MIT"]
  s.authors      = package["alexnderpetree"]
  s.platforms    = 
{ :ios => "11.0" }
  s.source       =
{ :git =
"https://github.com/coinbase/waas-sdk-react-native.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,m,mm,swift}"

  s.vendored_frameworks = 'ios/WaasSdkGo.xcframework', 'ios/openssl_libcrypto.xcframework'
  # Standard XCFrameworks that are used in this SDK.
  s.framework = "LocalAuthentication"
  s.libraries = 'resolv'
  s.dependency "React-Core"
  # Don't install the dependencies when we run `pod install` in the old architecture.
  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
        "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
    }
    s.dependency "React-Codegen"
    s.dependency "RCT-Folly"
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
  end
end
