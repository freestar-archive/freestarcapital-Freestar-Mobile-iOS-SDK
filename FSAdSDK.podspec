Pod::Spec.new do |s|

  s.name             = 'FSAdSDK'
  s.version          = '0.0.1'
  s.summary          = 'Freestar iOS Mobile Advertising SDK.'
  s.description      = "Freestar's SDK to easily display ads from over 30 demand sources. Visit freestar.io for more info."
  s.homepage         = 'https://freestar.io'
  s.author           = { 'Freestar - Dean Chang' => 'dean.chang@freestar.io' }
  s.license          = { :type => 'Freestar Limited License' }
  s.platform         = :ios, '8.0'
  s.source           = { :git => 'https://github.com/freestarcapital/Freestar-Mobile-iOS-SDK.git', :tag => s.version.to_s }
  s.xcconfig         =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/Google-Mobile-Ads-SDK/Frameworks/frameworks/"' }
  s.default_subspec  = 'Core'
  s.dependency	       'FSCache'

  s.subspec 'Core' do |core|
    core.dependency 'FSAdSDK/Registration'
    core.dependency 'FSAdSDK/Common'
  end

  s.subspec 'Registration' do |registration|
    registration.source_files = 'SDK/FSAdSDK.framework/Headers/*.{h}'
    registration.vendored_frameworks = 'SDK/FSAdSDK.framework'
    registration.preserve_paths =  'SDK/FSAdSDK.framework/*'
  end

  s.subspec 'Common' do |common|
    common.source_files = 'SDK/FSCommon.framework/Headers/*.{h}'
    common.vendored_frameworks = 'SDK/FSCommon.framework'
    common.preserve_paths =  'SDK/FSCommon.framework/*'
  end

  s.subspec 'Banner' do |banner|
    banner.dependency 'FSAdSDK/Core'
    banner.source_files = 'SDK/FSBanner.framework/Headers/*.{h}'
    banner.vendored_frameworks = 'SDK/FSBanner.framework'
    banner.preserve_paths =  'SDK/FSBanner.framework/*'
  end

end
