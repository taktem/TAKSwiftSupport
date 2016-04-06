#
#  Be sure to run `pod spec lint TAKAlertUtil.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TAKSwiftSupport"
  s.version      = "0.7.7"
  s.summary      = "Swift Support Project"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.homepage     = "https://github.com/taktem/TAKSwiftSupport"
  s.author       = { "taktem" => "nishimura[at]taktem.com" }
  s.source       = { :git => "https://github.com/taktem/TAKSwiftSupport.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'TAKSwiftSupport/Core/**/*.swift'
    ss.dependency 'Alamofire', '~> 3.1.5'
    ss.dependency 'RxSwift', '~> 2.3.1'
    ss.dependency 'RxCocoa', '~> 2.3.1'
    ss.dependency 'RxBlocking', '~> 2.3.1'
    ss.dependency 'ObjectMapper', '~> 1.2.0'
  end

  s.subspec 'CoreMotion' do |ss|
    ss.source_files = 'TAKSwiftSupport/CoreMotion/**/*.swift'
    ss.dependency 'TAKSwiftSupport/Core'
    ss.frameworks = 'CoreMotion'
  end

  s.subspec 'Math' do |ss|
    ss.source_files = 'TAKSwiftSupport/Math/**/*.swift'
    ss.dependency 'TAKSwiftSupport/Core'
  end

  s.subspec 'Realm' do |ss|
    ss.source_files = 'TAKSwiftSupport/Realm/**/*.swift'
    ss.dependency 'TAKSwiftSupport/Core'
    ss.dependency 'RealmSwift', '= 0.98.5'
  end

  s.subspec 'CoreLocation' do |ss|
    ss.source_files = 'TAKSwiftSupport/CoreLocation/**/*.swift'
    ss.dependency 'TAKSwiftSupport/Core'
    ss.frameworks = 'CoreLocation'
  end

end
