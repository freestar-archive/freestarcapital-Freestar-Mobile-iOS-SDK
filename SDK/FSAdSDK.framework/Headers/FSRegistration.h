//
//  FSRegistration.h
//  FSAdSDK
//
//  Created by Dean Chang on 4/20/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

@import Foundation;

/**
 * Registration statuses.
 */
typedef NS_ENUM(NSUInteger, FSRegistrationStatus) {
    /**
     * Initial
     */
    FSRegistrationInitial = 0,
    /**
     * Error
     */
    FSRegistrationError = 1,
    /**
     * Ready
     */
    FSRegistrationReady = 2,
    /**
     * Success
     */
    FSRegistrationSuccess = 3
};

@class PBAdUnit;

extern NSString *const FSRegistrationStatusNotification;

/**
 * Registers application with Freestar.  It is required to register to enable access to all ad inventory.
 */
@interface FSRegistration : NSObject

/**
 * This method allows the developer to register the ad units created for Prebid Mobile.
 */
+ (void)register;

/**
 * This method allows the developer to register the ad units created for Prebid Mobile.
 * @param completion completion block that returns success boolean and AdUnits
 */
+ (void)registerWithCompletion:(nullable void(^)(FSRegistrationStatus, NSArray<PBAdUnit *> *))completion;

/**
 * This method allows the developer to register the ad units created for Prebid Mobile.
 * @param adUnits Array of AdUnits that can be registered.
 * @param accountId Prebid server accountId.
 */
+ (void)registerAdUnits:(nonnull NSArray<PBAdUnit *> *)adUnits
          withAccountId:(nonnull NSString *)accountId;

/**
 * This method allows the developer to check for the registration success or failure.
 * @return boolean value where true indicates success, false failure.
 */
+ (BOOL)isRegistered;

/**
 * This method allows the developer to turn on or off registration retry (5 max).
 * @param autoRetry Boolean flag that enables or disabled auto retry, defaults to true.
 */
+ (void)setAutoRetry:(BOOL)autoRetry;

@end
