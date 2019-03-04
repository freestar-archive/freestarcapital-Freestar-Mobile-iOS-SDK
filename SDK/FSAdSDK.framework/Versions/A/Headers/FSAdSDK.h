//
//  FSAdSDK.h
//  FSAdSDK
//
//  Created by Dean Chang on 4/11/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for FSAdSDK.
FOUNDATION_EXPORT double FSAdSDKVersionNumber;

//! Project version string for FSAdSDK.
FOUNDATION_EXPORT const unsigned char FSAdSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FSAdSDK/PublicHeader.h>
#import "FSRegistration.h"
#import "FSAdProvider.h"
#import "FSAdSDKConstants.h"

/**
 * Umbrella class for generic application settings.
 */
@interface FSAdSDK : NSObject

/**
 * Test mode points to the FS test environment.
 * @param testMode Test mode flag where true enables test mode, false otherwise.
 */
+ (void)setTestMode:(BOOL)testMode;

/**
 * Setting related to the sending of SDK analytics.
 * @param enabled true will enabled the sending of analytics, false otherwise.
 */
+ (void)setAnalyticsEnabled:(BOOL)enabled;

/**
 * Setting related to overriding bundle identifier.  For test use only.
 * @param bundleIdentifier identifier to use for bundle id.
 */
+ (void)overrideBundleIdentifier:(NSString*)bundleIdentifier;

@end
