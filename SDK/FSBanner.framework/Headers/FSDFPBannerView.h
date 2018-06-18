//
//  FSDFPBannerView.h
//  FSAdSDK
//
//  Created by Dean Chang on 5/17/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMobileAds;

@class DFPBannerView;

@interface FSDFPBannerView : DFPBannerView <GADBannerViewDelegate>

@property (nonatomic, assign) NSTimeInterval fsRefreshRate;
@property (nonatomic, copy) NSString *fsIdentifier;

- (instancetype)initWithEventHandler:(void(^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler;

@end
