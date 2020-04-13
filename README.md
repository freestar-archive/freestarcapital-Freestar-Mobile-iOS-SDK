![Freestar](Resources/images/freestar.jpg)
# Freestar Mobile iOS SDK Integration Guide

### What's New
We are pleased to announce the release of our SDK! Banner and interstitial ad formats are currently supported, with more coming.  Be sure to check-in frequently for the latest releases and announcements.

###### Change History
| Version | Release Date | Description |
| ---- | ------- | ----------- |
| __0.6.7__ | _April 13th, 2020_ |  • Banner autoload feature.|
| __0.6.6__ | _February 6th, 2020_ |  • [GMA SDK 7.55.0 compatibility](#gma-sdk-compatibility-matrix).<br> • Build optimization level increase.<br> • Decrease network timeout(s).|
| __0.6.4__ | _January 22nd, 2020_ |  • [GMA SDK 7.53.1 compatibility](#gma-sdk-compatibility-matrix).|
| __0.6.3__ | _January 9th, 2020_ |  • Dashboard compatibility release.|
| __0.6.2__ | _November 15th, 2019_ |  • [Facebook Audience Network](#facebook-audience-network) mediation support.|
| __0.6.0__ | _October 23th, 2019_ |  • Firebase analytics compatibility fix.<br> • Minimum iOS deployment target 9.0.<br> • [GMA SDK 7.50.0 compatibility](#gma-sdk-compatibility-matrix).|
| __0.5.2__ | _October 15th, 2019_ |  • Null check for ad refresh rate.|
| __0.5.0__ | _September 23th, 2019_ |  • Swift 5.1 module stability.<br> • [GMA SDK 7.50.0 compatibility](#gma-sdk-compatibility-matrix).|
| __0.4.7__ | _September 10th, 2019_ |  • [MoPub mediation](#mopub) support.|
| __0.4.6__ | _August 26th, 2019_ |  • Analytics remote switch.|
| __0.4.5__ | _June 24th, 2019_ |  • Queuing for analytics delivery (protobuf messages).|
| __0.4.4__ | _June 12th, 2019_ |  • Registration retry policy.|
| __0.4.3__ | _May 29th, 2019_ |  • Public setter for root view controller on banner view.|
| __0.4.2__ | _May 21th, 2019_ |  • Fixed ad event function name constants.|
| __0.4.1__ | _May 20th, 2019_ |  • Fixed fill rate issue for banner ads.|
| __0.4.0__ | _May 16th, 2019_ |  • [GMA SDK 7.41.0 compatibility](#gma-sdk-compatibility-matrix).<br> • Runtime adjustable refresh rates.<br> • Nullability updates.|
| __0.3.2__ | _May 14th, 2019_ |  • Prebid Mobile SDK is now an internal dependency, see updated Podfile. |
| __0.3.1__ | _February 13th, 2019_ |  • Bundle id override, for testing only. |
| __0.3.0__ | _January 7th, 2019_ |  • Dynamic iTunes Id.<br> • Ad size lock down.<br> |
| __0.2.0__ | _November 20th, 2018_ |  • Analytics support.<br> • GMA SDK runtime updates.<br> • Pause and resume API for banner auto-refresh.<br> • Event name convenience constants. |
| __0.1.1__ | _August 13th, 2018_ |  • Fix to registration fallback url. |
| __0.1.0__ | _August 6th, 2018_ |  • Interstitial support.<br> • Registration status delegate.<br> • Removed unnecessary dependency to core framework. |
| __0.0.1__ | _June 21st, 2018_ |  • Initial release. |

###### Major API Changes
| Latest |
| ---- |
| [ __0.6.7__ ] <br> • Banner autoload feature.  This can be enabled or disabled via the [API](https://htmlpreview.github.io/?https://github.com/freestarcapital/Freestar-Mobile-iOS-SDK/blob/master/Resources/docs/html/Protocols/FSBanner.html#//api/name/fsAutoLoadEnabled).  |

_Warning: This step is required as of Google Mobile Ads SDK version 7.42.0. Failure to add add this Info.plist entry results in a crash with the message: "The Google Mobile Ads SDK was initialized incorrectly."_<br>
Info.plist:
```swift
<key>GADIsAdManagerApp</key>
<true/>
```

| Previous |
| ---- |
[ __0.6.0__ ] <br> • Usage of the forked GMA SDK is no longer needed, however version pinning is still required.  See [compatibility matrix](#gma-sdk-compatibility-matrix) below.|
| [ __0.5.0__ ] <br>• Xcode 11+ upgrade required.<br> • Update your _Info.plist_ to enable [GADIsAdManagerApp](https://developers.google.com/ad-manager/mobile-ads-sdk/ios/quick-start#update_your_infoplist) key.|
| [ __0.4.7__ ] <br>• [MoPub mediation](#mopub) support.<br>|
| [ __0.4.3__ ] <br>• Deprecated existing createBanner API.<br>|
| [ __0.4.0__ ] <br>• Nullability API updates.<br>• [Podfile](#using-cocoapods) updates.<br> |
| [ __0.2.0__ ]<br>• [Pause and resume](#banner-auto-refresh-pause-and-resume) for banner auto-refresh.<br>• [Banner convenience constants](#banner-ad-events-matrix) to detect event handler callback parameter.<br>• [Interstitial convenience constants](#interstitial-ad-events-matrix) to detect interstitial event handler callback parameter.<br>|
| [ __0.1.0__ ]<br>• Change to ad provider createBanner method.  Added registration delegate parameter.  Support for [interstitial](#interstitial) ad format. |

###### GMA SDK Compatibility Matrix
Starting with SDK version 0.6.0, it is no longer required to use the forked version of GMA SDK.  Please refer to below matrix to determine which version of GMA SDK is compatible to our Freestar SDK.  Whenever possible, it is always recommended to be on the latest version(s).

| FSAdSDK Version | GMA SDK Version | unForked? | Podfile |
| ---- | ----- | -- | ------------ |
| ~> 0.6.6 | 7.55.0 | :ballot_box_with_check: | pod 'Google-Mobile-Ads-SDK', '7.55.0' |
| ~> 0.6.4 | 7.53.1 | :ballot_box_with_check: | pod 'Google-Mobile-Ads-SDK', '7.53.1' |
| ~> 0.6.3 | 7.50.0 | :ballot_box_with_check: | pod 'Google-Mobile-Ads-SDK', '7.50.0' |
| ~> 0.5 | 7.50.0 | :x: | pod 'Google-Mobile-Ads-SDK', :git => 'https://github.com/freestarcapital/GMA-iOS-SDK.git', :tag => '7.50.0' |
| ~> 0.4 | 7.41.0 | :x: | pod 'Google-Mobile-Ads-SDK', :git => 'https://github.com/freestarcapital/GMA-iOS-SDK.git', :tag => '7.41.0' |
| <= 0.3.2 | 7.24.1 | :ballot_box_with_check: | pod 'Google-Mobile-Ads-SDK', '~> 7.24.1' |

---
#### Minimum Requirements
+ Mac running macOS 10.13.2 or later
+ XCode 9
+ Cocoapods
+ Device
  - iOS 9.0+

## Getting Started
---
Here are the basic steps required to download and link the SDK to your project.  Although there are many approaches to this, we highly recommend you to use the [Cocoapods](https://cocoapods.org/) method.

###### Using Cocoapods
The Freestar Ad SDK is available through [Cocoapods](https://cocoapods.org/), which is the de facto dependency manager for iOS projects. Here are the steps required to download and incorporate the SDK into your project. It is highly recommended to use Cocoapods, as that is the fastest way to get up and running with our SDK.

`1.` Update your _Podfile_, here is an example:  

```swift
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target "YourAppTarget" do
    pod 'FSAdSDK/Banner'
    pod 'Google-Mobile-Ads-SDK', '7.55.0'
end
```

`2.` Run "pod install" or "pod update".  
`3.` That's it as far as linking the SDK !! To continue, skip down to the [code integration](#code-integration) section of this document and follow those steps to complete the integration process.

###### Or Manually, Using Git
Please [contact us](mailto:dean.chang@freestar.io) for details.

### Code Integration
To be able to show ads from all demand sources, it is important to follow these steps for proper integration of the SDK into your app.  

###### Banner
To see a working example, there is a sample banner app project included in this repository.  See the [banner sample](Examples/FreestarBannerApp/).

`1.`  Register your app with Freestar in _AppDelegate.didFinishLaunchingWithOptions()_:
```swift
import UIKit
import FSAdSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    ...

    // Freestar app registration
    FSRegistration.register() // ensure your bundle identifier
    return true
}
```

`2.`  Create your banner ad object(s), preferably in _ViewController.viewDidLoad()_.
```swift
import UIKit
import FSAdSDK
import GoogleMobileAds

class ViewController: UIViewController {    
    let adUnitID = "/your_dfp_adunit_ID/placement_id"   // DFP Ad Unit ID
    let adIdentifier = "your_freestar_ad_identifier"    // Freestar Ad Identifier
    var bannerView: (UIView & FSBanner)?                // banner

    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView = FSAdProvider.createBanner(withIdentifier: adIdentifier,
                                               size: kGADAdSizeBanner,       
                                               adUnitId: adUnitID,
                                               registrationDelegate: self,
                                               eventHandler:nil)

        bannerView?.rootViewController = self
        let request: DFPRequest? = DFPRequest()
        bannerView?.load(request)
        addToView(bannerView) // for layout, see banner sample
    }
    ...
}
```

`3.`  Optional, to receive the registration status, implement FSRegistrationDelegate.  If so, please remember to pass self into the ad provider convenience constructor as the registrationDelegate parameter.
```swift
class ViewController: UIViewController, FSRegistrationDelegate {
  ...
  func didRegister(forIdentifier identifier: String) {
    print("didRegister: \(identifier)")
  }

  func didFailToRegister(forIdentifier identifier: String) {
    print("didFailToRegister: \(identifier)")
  }
}
```

###### Banner Auto Refresh Pause and Resume

`1.`  Optional, to pause or resume banner auto-refresh, call _resumeRefresh()_ or _pauseRefresh()_.  During moments when the banner is still in the window but is behind other views, it is recommended to pause auto-refresh.  Also be sure to resume refresh when appropriate.
```swift
override func viewWillDisappear(_ animated: Bool) {
  bannerView!.pauseRefresh()
}

override func viewWillAppear(_ animated: Bool) {
  bannerView!.resumeRefresh()
}
```

###### Interstitial
To see a working example, there is a sample interstitial app project included in this repository.  See the [interstitial sample](Examples/FreestarInterstitialApp/).

`1.`  Register your app with Freestar in _AppDelegate.didFinishLaunchingWithOptions()_:
```swift
import UIKit
import FSAdSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?    

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  ...

  // Freestar app registration
  FSRegistration.register() // ensure your bundle identifier
  return true
}
```

`2.`  Create your interstitial ad object(s), preferably in _ViewController.viewDidLoad()_.
```swift
import UIKit
import FSAdSDK
import GoogleMobileAds

class ViewController: UIViewController {
  let adUnitID = "/your_dfp_adunit_ID/placement_id"   // DFP Ad Unit ID
  let adIdentifier = "your_freestar_ad_identifier"    // Freestar Ad Identifier
  var interstitial: FSInterstitial?  // interstitial

  override func viewDidLoad() {
     super.viewDidLoad()

     interstitial = FSAdProvider.createInterstitial(withIdentifier: adIdentifier, adUnitId: adUnitID, registrationDelegate: nil, eventHandler: nil)
     let request: DFPRequest? = DFPRequest()
     interstitial?.load(request)
   }
   ...
}
```

`3.`  When ready, present your interstitial.  Please ensure you are calling this on main thread.
 ```swift
class ViewController: UIViewController {

  func someMethod() {
    ...
    self.presentInterstitial()  // main thread
  }

  func presentInterstitial() {
       if (interstitial!.isReady) {
           interstitial?.present(fromRootViewController: self)
       }
   }
   ...
 }
 ```

`4.`  Optional, to receive the registration status, implement FSRegistrationDelegate.  If so, please remember to pass self into the ad provider convenience constructor as the registrationDelegate parameter.

```swift
class ViewController: UIViewController, FSRegistrationDelegate {
...
  func didRegister(forIdentifier identifier: String) {
    print("didRegister: \(identifier)")
  }

  func didFailToRegister(forIdentifier identifier: String) {
    print("didFailToRegister: \(identifier)")
  }
}
```

## Event Handler
Often times it is necessary to receive ad event callbacks, such as when an ad is received or when an ad has failed to load.  These callbacks are handled through the eventHandler method parameter (refer to the [reference guide](#reference-guide) relating to _FSAdProvider.createBanner_ or _FSAdProvider.createInterstitial_).  
<br>
_Warning: It is up to the discretion of the developer on how to handle these events, the below snippets are just generalized examples.  Do not implement this in your code without modification._

#### Banner Event Handler
```swift
eventHandler: { [weak self] (methodName: String!, params: [ String : Any]) in...
```
There are two parameters that are passed into the eventHandler closure expression, one is the methodName (string type) and the other is the parameter info (key value type).  Below are some common ad events and examples of how each of these events can be handled.  

###### adViewDidReceiveAd:

In order to react to the receiving of an ad, the eventHandler must check for a matching methodName parameter.  In this case the methodName parameter is **_adViewDidReceiveAd:_**. Here is an example which adds the banner view to it's parent view when an ad is received:
```swift
bannerView = FSAdProvider.createBanner(withIdentifier: adIdentifier,
                                       size: kGADAdSizeMediumRectangle,
                                       adUnitId: adUnitID,
                                       rootViewController: self,
                                       registrationDelegate: nil,
                                       eventHandler: { [weak self] (methodName: String!, params: [ String : Any]) in
                                            // create a reference to the banner
                                            let banner: UIView? = params["bannerView"] as? UIView
                                            if (methodName == DFPEventNameBanner.adViewDidReceiveAd.rawValue) {
                                                // convenience method to add the banner to self.view
                                                self?.addToView(banner)
                                            }
                                    })
```

#### Banner Ad Events Matrix
Below is a chart that lists and describes all the ad events related to banner.

| Ad Event | Constant | Parameter Key(s) | Description |
| ------- | ------ | ------- | ----------- |
| -adViewDidReceiveAd: | *DFPEventNameBannerAdViewDidReceiveAd* | bannerView | Ad request successfully received an ad. |
| -adView:didFailToReceiveAdWithError:	| *DFPEventNameBannerAdViewDidFailToReceiveAd* | bannerView, error | Ad request failure, or no ad available. |
| -adViewWillPresentScreen: | *DFPEventNameBannerAdViewWillPresentFullScreen* | bannerView | A full screen view will be presented in response to the user tapping on an ad. |
| -adViewWillDismissScreen: | *DFPEventNameBannerAdViewWillDismissScreen* | bannerView | The full screen view will be dismissed. |
| -adViewDidDismissScreen: | *DFPEventNameBannerAdViewDidDismissScreen* | bannerView | The full screen view has been dismissed. |
| -adViewWillLeaveApplication: | *DFPEventNameBannerAdViewWillLeaveApplication* | bannerView | The user click will open another app, backgrounding the current application |

#### Interstitial Ad Events Matrix
| Ad Event (methodName) | Constant | Parameter Key(s) | Description |
| ---- | ------ | ------- | ----------- |
| -interstitialDidReceiveAd: | *DFPEventNameInterstitialDidReceiveAd* | interstitial | Interstitial ad request succeeded. |
| -interstitial:didFailToReceiveAdWithError: | *DFPEventNameInterstitialDidFailToReceiveAdWithError* | interstitial, error | Interstitial ad request completed without an interstitial to show. |
| -interstitialWillPresentScreen: | *DFPEventNameInterstitialWillPresentScreen* | interstitial | Interstitial will animate onto the screen. |
| -interstitialDidFailToPresentScreen: | *DFPEventNameInterstitialDidFailToPresentScreen* | interstitial | Interstitial failed to present. |
| -interstitialWillDismissScreen: | *DFPEventNameInterstitialWillDismissScreen* | interstitial | Interstitial is to be animated off the screen. |
| -interstitialDidDismissScreen: | *DFPEventNameInterstitialDidDismissScreen* | interstitial | Interstitial has animated off the screen. |
| -interstitialWillLeaveApplication: | *DFPEventNameInterstitialWillLeaveApplication* | interstitial | Application will background or terminate because the user clicked on an ad that will launch another application. |

## Targeting Parameters
To be able to support targeting for our various demand partners, it is important to use the Prebid Mobile API.  By using this API, the developer is assured that targeting will be set on all Prebid related ad objects.

#### User Location
By default, the iOS Prebid Mobile SDK does not automatically send location information. In order for Prebid Mobile to use location information for targeting, the app developer must explicitly pass the location information to the Prebid Mobile API.

_Note: Developers should ensure adequate consent is obtained before sharing location information. Developers can control whether location is collected and sent by the SDK._

In this snippet, we create a location manager property, create a _setupLocationManager()_ method and implement the _CLLocationManagerDelegate_ delegate:

```swift
import UIKit
import CoreLocation
import PrebidMobileFS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
  var locationManager: CLLocationManager = CLLocationManager()

  ...

  func setupLocationManager() {
    // guard to ensure minimum iOS level
    guard #available(iOS 8, *) else {
        return
    }

    locationManager.delegate = self
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }


  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    PBTargetingParams.sharedInstance().location = locations.last
  }
}

```

#### Age and Gender

```swift
import UIKit
import PrebidMobileFS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?    

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {\
    PBTargetingParams.sharedInstance().age = 24;
    PBTargetingParams.sharedInstance().gender = PBTargetingParamsGender.female;
  }
}
```

#### iTunes Id Override
Currently, demand partners use iTunes Track Id to identify iOS apps.  Normally, iTunes Id is set automatically (0.3.0+), however this provides a way to override the iTunes Id.

```swift
import UIKit
import PrebidMobileFS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?    

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    PBTargetingParams.sharedInstance().itunesID = "123456789"
  }
}
```

#### NSFW Content for AdX
To avoid getting AdX blacklisted, it is _required_ to pass an extra targeting parameter if there is NSFW content in the app due to GAM's (Google Ad Manager) content restriction guidelines.
```swift
  let request = DFPRequest()
  request.customTargeting = ["campaign" : "NSFW"]
```

#### GDPR Consent
Prebid Mobile supports the [IAB GDPR recommendations](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/Mobile%20In-App%20Consent%20APIs%20v1.0%20Draft%20for%20Public%20Comment.md). For a general overview of Prebid Mobile support for GDPR, see [Prebid Mobile Guide to European Ad Inventory and Providing Notice, Transparency and Choice]({{site.github.url}}/prebid-mobile/gdpr.html)

Enable or disable the ability to provide consent.  By default, GDPR is set to _false_.
```swift
  PBTargetingParams.sharedInstance().subjectToGDPR = true
```
_Note: If GDPR subject is set to true, setting the consent string is required._
```swift
  PBTargetingParams.sharedInstance().gdprConsentString = "sample_consent_string"
```
Prebid mobile also checks if the values are present in the [NSUserDefaults](https://developer.apple.com/documentation/foundation/nsuserdefaults#1664798?language=objc) keys specified by the IAB. If the values are also set in these objects they will be passed in the OpenRTB request object.

#### Custom Keywords
Custom keywords are used to attach arbitrary key/value pairs to the ad call. Use key/value pairs to add users to segments, as shown here:

```swift
  PBTargetingParams.sharedInstance().setUserKeywords("foo", withValues: ["bat"])
  PBTargetingParams.sharedInstance().setUserKeywords("foo", withValues: ["bee"])
  PBTargetingParams.sharedInstance().setUserKeywords("foo", withValues: ["bar"])
```
If a value is set for an existing keyword, the value for the key is replaced with the new value. In the preceding example, the key foo will have a value of _bar_, the most recent value associated with that key.

You can set a key to have an array of values with the following API:
```swift
  PBTargetingParams.sharedInstance().setUserKeywords("foo", withValues: ["bat", "bee", "bar"])
```
The preceding commands will result in the following request JSON body construct:
```swift
user = {
  keywords = "foo=bat,foo=bee,foo=bar";
};
```

## Analytics
Prebid analytics is disabled by default.  However, if granular reporting is required, please enable analytics using _PBAnalyticsManager_ in your AppDelegate.  Here is an example showing how to enable analytics:
```swift
import FSAdSDK

...

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  FSAdSDK.setAnalyticsEnabled(true)  
}
```

## Mediation
To enable support for 3rd party ad networks, follow the Cocoapods integration guideline(s) below.  Each mediation partner will require an entry to be added to your Podfile.  The mediation adapter module(s) below have been compatibility tested with our SDK.  No additional code integration is required.  

_Note: Alternatively, custom mediation adapters can be added to your project but caution will need to be exercised to ensure proper impression tracking and ad slot sizing._

#### MoPub
To enable MoPub demand (via mediation) in your project, add this entry to your Podfile:

```swift
target "YourAppTarget" do
  pod 'FSAdSDK/Mediation/MoPub'
  ...
end
```

Full Podfile example with MoPub:
```swift
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target "YourAppTarget" do
    pod 'FSAdSDK/Mediation/MoPub'
    pod 'FSAdSDK/Banner'
    pod 'Google-Mobile-Ads-SDK', '7.55.0'
end
```

#### Facebook Audience Network
To enable Facebook Audience Network demand (via mediation) in your project, add this entry to your Podfile:

```swift
target "YourAppTarget" do
  pod 'FSAdSDK/Mediation/Facebook'
  ...
end
```

Full Podfile example with Facebook:
```swift
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target "YourAppTarget" do
    pod 'FSAdSDK/Mediation/Facebook'
    pod 'FSAdSDK/Banner'
    pod 'Google-Mobile-Ads-SDK', '7.55.0'
end
```

## Reference Guide
The API reference guide for the SDK is available in this repository in HTML format. See [reference guide](Resources/docs/html/index.html).

## Diagnostics
Special modes can be enabled to help with diagnosing issues related to SDK integration.  See below instructions.

#### Fail Safe Visibility Mode
For display ad formats, such as banner, it is expected that display ads will be shown after ad loading has completed.  But, if for any reason, an ad cannot be displayed as a result of a bug in the integration, the SDK will not throw any errors or exceptions indicating an impression was lost.  Under these circumstances, it might be useful to have the SDK throw an exception to halt execution of the app to make the app developer aware that they are, potentially, losing out on said impression.  Halting the execution of an app due to error conditions is called fail safe mode.  Fail safe mode is disabled by default.  To enable fail safe mode in debug builds, follow the instructions below:

Update your application Info.plist with the following:
+ Create a dictionary entry at root called *freestar*
+ Add a sub-entry under *freestar* called *failsafeModeEnabled* and set that to true (YES).
```
Info.plist -> freestar (dictionary) -> failsafeModeEnabled (bool) = YES
```

---
## Questions
If you have any questions, don’t hesitate to [email us](mailto:dean.chang@freestar.io).  
Thank you.
