//
//  FSDFPInterstitial.h
//  FSDFP
//
//  Created by Dean Chang on 5/6/19.
//  Copyright © 2019 Freestar. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DFPNInterstitial.h"

@protocol FSRegistrationDelegate;

@interface FSDFPInterstitial : DFPNInterstitial <GADInterstitialDelegate>

@property (nonatomic, copy, nullable) NSString *fsIdentifier;
@property (nonatomic, weak, nullable) id<FSRegistrationDelegate> registrationDelegate;

- (__nonnull instancetype)initWithEventHandler:(void(^__nullable)(NSString *__nonnull methodName, NSDictionary<NSString *, id> *__nullable params))eventHandler
                                      adUnitId:(NSString *__nonnull)adUnitId;

@end
