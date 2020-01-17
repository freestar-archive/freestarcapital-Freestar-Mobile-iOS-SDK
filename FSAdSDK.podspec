Pod::Spec.new do |s|

  s.name             = 'FSAdSDK'
  s.version          = '0.6.3'
  s.summary          = 'Freestar iOS Mobile Advertising SDK.'
  s.description      = "Freestar's SDK to easily display ads from over 30 demand sources. Visit freestar.io for more info."
  s.homepage         = 'https://freestar.io'
  s.author           = { 'Freestar - Dean Chang' => 'dean.chang@freestar.io' }
  s.license          = { :type => 'Freestar Limited License' }
  s.platform         = :ios, '9.0'
  s.source           = { :git => 'https://github.com/freestarcapital/Freestar-Mobile-iOS-SDK.git', :tag => s.version.to_s }
  s.default_subspec  = 'Core'
  s.swift_version    = '5.0'
  s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1' }

  s.subspec 'Core' do |core|
    core.dependency   'FSAdSDK/Registration'
    core.dependency	  'FSCache'
    core.dependency	  'FSCommon'
    core.dependency	  'FSDFP'
    core.dependency	  'Protobuf', '~> 3.10.0'
    core.dependency	  'PrebidMobileFS', '~> 0.6.1'
  end

  s.subspec 'Registration' do |registration|
    registration.source_files = 'SDK/FSAdSDK.framework/Headers/*.{h}'
    registration.vendored_frameworks = 'SDK/FSAdSDK.framework'
    registration.preserve_paths =  'SDK/FSAdSDK.framework/*'
  end

  s.subspec 'Banner' do |banner|
    banner.dependency 'FSAdSDK/Core'
  end

  s.subspec 'Interstitial' do |interstitial|
    interstitial.dependency 'FSAdSDK/Core'
  end

  s.subspec 'Mediation' do |mediation|
    mediation.subspec 'MoPub' do |mopub|
      mopub.source = { 
        :http => 'https://storage.googleapis.com/freestar-sdk/MoPub/MoPub.tar.gz'
       }
       mopub.vendored_frameworks = 'Library/MoPubAdapter.framework'
       mopub.preserve_paths =  'Library/MoPubAdapter.framework/*'
       mopub.dependency 'mopub-ios-sdk/Core', '5.8.0'
       mopub.dependency 'Google-Mobile-Ads-SDK', '7.50.0'
    end

    mediation.subspec 'Facebook' do |facebook|
       facebook.source = { 
        :http => 'https://storage.googleapis.com/freestar-sdk/Facebook/Facebook.tar.gz'
       }
       facebook.vendored_frameworks = 'Library/FacebookAdapter.framework'
       facebook.preserve_paths =  'Library/FacebookAdapter.framework/*'
       facebook.dependency 'FBAudienceNetwork', '5.6.0'
       facebook.dependency 'Google-Mobile-Ads-SDK', '7.50.0'
    end

  end

end
