Pod::Spec.new do |s|
  s.name          = "TaktemSwiftSupport"
  s.version       = "0.1"
  s.summary       = "An utility library maintained by taktem"
  s.homepage      = "https://github.com/taktem/TAKSwiftSupport"
  s.license       = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author        = { "taktem.com" => "totem.kc@me.com" }
  s.platform      = :ios
  s.source        = { :git => "https://github.com/taktem/TaktemSwiftSupport.git", :tag => "#{s.version}" }
  s.source_files  = "Class", "Class/*"
  s.requires_arc  = true
  s.ios.deployment_target = '8.0'
end
