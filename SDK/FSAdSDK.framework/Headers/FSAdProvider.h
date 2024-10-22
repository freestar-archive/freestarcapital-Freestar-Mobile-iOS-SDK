//
//  FSAdProvider.h
//  FSAdSDK
//
//  Created by Dean Chang on 5/17/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

@class GADRequest;
typedef struct GADAdSize GADAdSize;

/**
 * Protocol that informs the delegate of registration status.
 */
@protocol FSRegistrationDelegate <NSObject>

/**
 * This method notifies the delegate when the registration was successful.
 * @param identifier A unique ad idenitifier.
 */
- (void)didRegisterForIdentifier:(NSString *_Nonnull)identifier;

/**
 * This method notifies the delegate when the registration has failed.
 * @param identifier A unique ad idenitifier.
 */
- (void)didFailToRegisterForIdentifier:(NSString *_Nonnull)identifier;

@end

/**
 * Protocol that defines a ad object.
 */
@protocol FSAdObject <NSObject>

/**
 * The ad loader's ad unit ID.
 */
@property (nonatomic, copy, readonly, nullable) NSString *adUnitId;

/**
 * Freestar unique ad identifier, readonly.
 */
@property (nonatomic, copy, readonly, nullable) NSString *fsIdentifier;

/**
 * Delegate for Freestar registration, optional, weak reference.
 */
@property (nonatomic, weak, nullable) id<FSRegistrationDelegate> registrationDelegate;

/**
 * This method allows the developer to load an ad request, applies to DFP only.
 * @param request DFP request.
 */
- (void)loadRequest:(nullable GADRequest *)request;

@end

/**
 * Protocol that defines a banner.
 */
@protocol FSBanner <FSAdObject>

/**
 * Ad size (width, height), readonly.
 */
@property(nonatomic, readonly, assign) CGSize fsAdSize;

/**
 * Refresh rate, defaults to app config setting.
 */
@property (nonatomic, assign) NSTimeInterval fsRefreshRate;

/**
 * Autoload, defaults to true.  When set to true, any banner ad that is in the window, will get automatically refreshed or paused
 * when the app session becomes active or resigns active, respectively.
 */
@property (nonatomic, assign, getter=isFsAutoLoadEnabled) BOOL fsAutoLoadEnabled;


/**
 * Root view controller for the banner view, required, weak reference.
 */
@property(nonatomic, weak, nullable) IBOutlet UIViewController *rootViewController;


/**
 * This method allows the developer to pause autoRefresh of an ad.
 */
- (void)pauseRefresh;

/**
 * This method allows the developer to resume autoRefresh of a paused ad.  Note:
 * Calling this method will cause the banner to immediately reload.
 */
- (void)resumeRefresh;

@end

/**
 * Protocol that defines an interstitial.
 */
@protocol FSInterstitial <FSAdObject>

/**
 * @field ready Returns YES if the interstitial is ready to be displayed.
 */
@property(nonatomic, readonly, assign) BOOL isReady;

/**
 * This method allows the developer to present an interstitial ad in fullscreen mode until the user dismisses it.
 * @param rootViewController The root view controller is used to present ad click actions. If your application does not use view controllers, pass in nil and your views will be removed from the window to show the interstitial, and restored when done.
 * @note This has no effect unless isReady returns YES.
 */
- (void)presentFromRootViewController:(UIViewController *_Nullable)rootViewController;

@end

/**
 * Class that provides convenience constructors to create ad objects, such as banner.
 */
@interface FSAdProvider : NSObject

/**
 * This method allows the developer to create an instance of a banner ad.
 * @param identifier String that represents the unique identifier of the instance.
 * @param size Struct that represents the size dimensions (height and width) of the instance.
 * @param adUnitId The ad loader's ad unit ID.
 * @param registrationDelegate Informs delegate of registration status.
 * @param eventHandler Callback that notifies the developer to certain ad events, such as adViewDidReceiveAd or didFailToReceiveAdWithError.
 * @return banner object which is an instance of UIView and conforms to the FSBanner protocol.
 * @see FSBanner
 */
+ (nullable UIView<FSBanner>*)createBannerWithIdentifier:(nonnull NSString*)identifier
                                                    size:(GADAdSize)size
                                                adUnitId:(nonnull NSString*)adUnitId
                                    registrationDelegate:(nullable id<FSRegistrationDelegate>)registrationDelegate
                                            eventHandler:(nullable void (^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler;

/**
 * This method allows the developer to create an instance of a banner ad.
 * @param identifier String that represents the unique identifier of the instance.
 * @param size Struct that represents the size dimensions (height and width) of the instance.
 * @param adUnitId The ad loader's ad unit ID.
 * @param rootViewController The root view controller is used to present ad click actions.
 * @param registrationDelegate Informs delegate of registration status.
 * @param eventHandler Callback that notifies the developer to certain ad events, such as adViewDidReceiveAd or didFailToReceiveAdWithError.
 * @return banner object which is an instance of UIView and conforms to the FSBanner protocol.
 * @see FSBanner
 * @deprecated
 */
+ (nullable UIView<FSBanner>*)createBannerWithIdentifier:(nonnull NSString*)identifier
                                                    size:(GADAdSize)size
                                                adUnitId:(nonnull NSString*)adUnitId
                                      rootViewController:(nullable UIViewController*)rootViewController
                                    registrationDelegate:(nullable id<FSRegistrationDelegate>)registrationDelegate
                                            eventHandler:(nullable void (^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler
DEPRECATED_ATTRIBUTE;

/**
 * This method allows the developer to create an instance of an interstitial.
 * @param identifier String that represents the unique identifier of the instance.
 * @param adUnitId The ad loader's ad unit ID.
 * @param registrationDelegate Informs delegate of registration status.
 * @param eventHandler Callback that notifies the developer to certain ad events, such as interstitialDidReceiveAd or didFailToReceiveAdWithError.
 * @return interstitial object which conforms to the FSInterstitial protocol.
 * @see FSInterstitial
 */
+ (nullable UIView<FSInterstitial>*)createInterstitialWithIdentifier:(nonnull NSString*)identifier
                                                            adUnitId:(nonnull NSString*)adUnitId
                                                registrationDelegate:(nullable id<FSRegistrationDelegate>)registrationDelegate
                                                        eventHandler:(nullable void (^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler;


@end
