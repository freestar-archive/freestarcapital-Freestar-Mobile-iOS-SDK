![Freestar](Resources/images/freestar.jpg)
# Freestar Mobile iOS SDK Integration Guide

### What's New
We are pleased to announce the release of our SDK !! Banner and interstitial ad formats are currently supported, with more coming.  Be sure to check-in frequently for the latest releases and announcements.

###### Change History
| Version | Release Date | Description |
| ---- | ------- | ----------- |
| __0.0.1__ | _June 21st, 2018_ |  • Initial release. |
| __0.1.0__ | _August 6th, 2018_ |  • Interstitial support.<br> • Registration status delegate.<br> • Removed unnecessary dependency to core framework.

###### API Changes
 [ __0.1.0__ ] Change to ad provider createBanner method.  Added registration delegate parameter.  Support for [interstitial](#interstitial) ad format.

---
#### Minimum Requirements
+ Mac running macOS 10.13.2 or later
+ XCode 9
+ Cocoapods
+ Device
  - iOS 8.0+

## Getting Started
---
Here are the basic steps required to download and link the SDK to your project.  Although there are many approaches to this, we highly recommend you to use the [Cocoapods](https://cocoapods.org/) method.

###### Using Cocoapods (recommended)
The Freestar Ad SDK is available through [Cocoapods](https://cocoapods.org/), which is the de facto dependency manager for Objective-C projects. Here are the steps required to download and incorporate the SDK into your project.  

`1.` Update your _Podfile_, here is an example:  

```objective-c
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target "YourAppTarget" do
    pod 'FSAdSDK/Banner'  // Freestar Ad SDK
    pod 'PrebidMobileFS'  // Prebid Mobile SDK
    pod 'Google-Mobile-Ads-SDK', '~> 7.24.1'  // Primary Ad SDK
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
                                               rootViewController: self,
                                               registrationDelegate: self,
                                               eventHandler:nil)

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
  func didRegister(forIdentifier identifier: String!) {
    print("didRegister: \(identifier)")
  }

  func didFailToRegister(forIdentifier identifier: String!) {
    print("didFailToRegister: \(identifier)")
  }
}
```

`4.`  Congratulations, that's it!


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
  func didRegister(forIdentifier identifier: String!) {
    print("didRegister: \(identifier)")
  }

  func didFailToRegister(forIdentifier identifier: String!) {
    print("didFailToRegister: \(identifier)")
  }
}
```

`5.`  Congratulations, that's it!


## Reference Guide
The API reference guide for the SDK is available in this repository in HTML format. See [reference guide](Resources/docs/html/index.html).

---
## Questions
If you have any questions, don’t hesitate to [email us](mailto:dean.chang@freestar.io).  
Thank you.
