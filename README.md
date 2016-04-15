TAKSwiftSupport
===========

Swift用汎用クラス集

##Installation with CocoaPods

###Requirements
requires iOS 8 & Xcode7.3

###Podfile
```ruby
pod 'TAKSwiftSupport/Core'
```

#####If use DebugLog
```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'TAKSwiftSupport'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] = '$(inherited) -D DEBUG -D COCOAPODS'
                else
                    config.build_settings['OTHER_SWIFT_FLAGS'] = '$(inherited) -D COCOAPODS'
                end
            end
        end
    end
end
```

License
---

TAKSwiftSupport is released under the MIT license. See LICENSE for details.

