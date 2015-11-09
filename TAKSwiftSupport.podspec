#
#  Be sure to run `pod spec lint TAKAlertUtil.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TAKSwiftSupport"
  s.version      = "0.1.4"
  s.summary      = "Swift Handler"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.homepage     = "https://github.com/taktem/TAKSwiftSupport"
  s.author       = { "SOMTD" => "nishimura[at]taktem.com" }
  s.source       = { :git => "https://github.com/taktem/TAKSwiftSupport.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'TAKSwiftSupport/Common/**/*.swift'
  s.dependency 'RxSwift', '~> 2.0.0-beta.2'
  s.dependency 'RxCocoa', '~> 2.0.0-beta.2'
  s.dependency 'RxBlocking', '~> 2.0.0-beta.2'

  s.subspec 'Extention' do |ss|
    ss.source_files = 'TAKSwiftSupport/Extention/**/*.swift'
  end
end
