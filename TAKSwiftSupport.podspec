#
#  Be sure to run `pod spec lint TAKAlertUtil.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TAKSwiftSupport"
  s.version      = "0.1.7"
  s.summary      = "Swift Handler"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.homepage     = "https://github.com/taktem/TAKSwiftSupport"
  s.author       = { "SOMTD" => "nishimura[at]taktem.com" }
  s.dependency 'TAKSwiftSupport/Core'

  s.subspec 'Core' do |ss|
    ss.source       = { :git => "https://github.com/taktem/TAKSwiftSupport.git", :tag => "#{s.version}" }
    ss.platform     = :ios, '8.0'
    ss.requires_arc = true
    ss.source_files = 'TAKSwiftSupport/Common/**/*.swift'
    ss.dependency 'Alamofire', '~> 3.1.1'
    ss.dependency 'RxSwift', '~> 2.0.0-beta.2'
    ss.dependency 'RxCocoa', '~> 2.0.0-beta.2'
    ss.dependency 'RxBlocking', '~> 2.0.0-beta.2'

  s.subspec 'Extention' do |ss|
    ss.source_files = 'TAKSwiftSupport/Extention/**/*.swift'
  end

  s.subspec 'CoreMotion' do |ss|
    ss.source_files = 'TAKSwiftSupport/CoreMotion/**/*.swift'
  end
  
end
