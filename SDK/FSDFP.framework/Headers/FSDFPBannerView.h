//
//  FSDFPBannerView.h
//  FSAdSDK
//
//  Created by Dean Chang on 5/17/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/DFPBannerView.h>

@protocol FSRegistrationDelegate;

@interface FSDFPBannerView : DFPBannerView <GADBannerViewDelegate>

@property (nonatomic, assign) NSTimeInterval fsRefreshRate;
@property (nonatomic, copy) NSString *fsIdentifier;
@property (nonatomic, weak) id<FSRegistrationDelegate> registrationDelegate;
@property (nonatomic, assign, getter=isPaused, readonly) BOOL paused;

/*! @abstract Use initWithEventHandler:size to init. */
- (instancetype)initWithEventHandler:(void(^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler;

- (instancetype)initWithEventHandler:(void(^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler size:(GADAdSize)adSize NS_DESIGNATED_INITIALIZER;

- (void)pauseRefresh;
- (void)resumeRefresh;

@end
