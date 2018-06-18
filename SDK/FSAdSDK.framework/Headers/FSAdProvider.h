//
//  FSAdProvider.h
//  FSAdSDK
//
//  Created by Dean Chang on 5/17/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GADRequest;
typedef struct GADAdSize GADAdSize;

/**
 * Protocol that defines a banner object.
 */
@protocol FSBanner <NSObject>

/**
 * The ad loader's ad unit ID
 */
@property (nonatomic, copy, readonly, nonnull) NSString *adUnitId;

/**
 * Freestar unique ad identifier, readonly
 */
@property (nonatomic, copy, readonly, nonnull) NSString *fsIdentifier;

/**
 * Refresh rate, defaults to app config setting
 */
@property (nonatomic, assign) NSTimeInterval fsRefreshRate;

/**
 * Ad size (width, height), readonly
 */
@property(nonatomic, readonly, assign) CGSize fsAdSize;

/**
 * This method allows the developer to load an ad request, applies to DFP only.
 * @param request DFP request.
 */
- (void)loadRequest:(nullable GADRequest *)request;

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
 * @param rootViewController The root view controller is used to present ad click actions.
 * @param eventHandler Callback that notifies the developer to certain ad events, such as adViewDidReceiveAd or didFailToReceiveAdWithError.
 * @return banner object which is an instance of UIView and conforms to the FSBanner protocol.
 * @see FSBanner
 */
+ (nullable UIView<FSBanner>*)createBannerWithIdentifier:(nonnull NSString*)identifier
                                                    size:(GADAdSize)size
                                                adUnitId:(nonnull NSString*)adUnitId
                                      rootViewController:(nullable UIViewController*)rootViewController
                                            eventHandler:(nullable void (^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler;

@end
