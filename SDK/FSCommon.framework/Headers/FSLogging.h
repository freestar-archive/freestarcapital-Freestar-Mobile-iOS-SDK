//
//  FSLogging.h
//  FSLogging
//
//  Created by Dean Chang on 4/20/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <Foundation/Foundation.h>


//! Project version number for FSLogging.
FOUNDATION_EXPORT double FSLoggingVersionNumber;

//! Project version string for FSLogging.
FOUNDATION_EXPORT const unsigned char FSLoggingVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FSLogging/PublicHeader.h>


/**
 The lower the filter level, the more logs will be shown.
 For example, `FSLogLevelInfo` will display messages from
 `FSLogLevelInfo,` `FSLogLevelWarn,` and `FSLogLevelError.`
 The default level is `FSLogLevelOff`
 */
typedef NS_ENUM(NSUInteger, FSLogLevel) {
    FSLogLevelOff = 0,
    FSLogLevelError = 1,
    FSLogLevelWarn,
    FSLogLevelInfo,
    FSLogLevelDebug,
    FSLogLevelTrace,
    FSLogLevelMark,
    FSLogLevelAll
};

/**
 Use the `FSLogManager` methods to set the desired level of log filter.
 */
@interface FSLogManager : NSObject

/**
 Gets the current log filter level.
 */
+ (FSLogLevel)getFSLogLevel;

/**
 Sets the log filter level.
 */
+ (void)setFSLogLevel:(FSLogLevel)level;

@end


#ifdef DEBUG

void _FSLog(FSLogLevel level, NSString *levelString, char const *logContext, NSString *format, ...)  NS_FORMAT_FUNCTION(4, 5);
#define FSLogMark()             _FSLog(FSLogLevelTrace, @"MARK",    __PRETTY_FUNCTION__, @"")
#define FSLogMarkMessage(...)   _FSLog(FSLogLevelTrace, @"MARK",    __PRETTY_FUNCTION__, __VA_ARGS__)
#define FSLogTrace(...)         _FSLog(FSLogLevelTrace, @"TRACE",   __PRETTY_FUNCTION__, __VA_ARGS__)
#define FSLogDebug(...)         _FSLog(FSLogLevelDebug, @"DEBUG",   __PRETTY_FUNCTION__, __VA_ARGS__)
#define FSLogInfo(...)          _FSLog(FSLogLevelInfo,  @"INFO",    __PRETTY_FUNCTION__, __VA_ARGS__)
#define FSLogWarn(...)          _FSLog(FSLogLevelWarn,  @"WARNING", __PRETTY_FUNCTION__, __VA_ARGS__)
#define FSLogError(...)         _FSLog(FSLogLevelError, @"ERROR",   __PRETTY_FUNCTION__, __VA_ARGS__)

#else

#define FSLogMark() {}
#define FSLogMarkMessage(...) {}
#define FSLogTrace(...) {}
#define FSLogDebug(...) {}
#define FSLogInfo(...) {}
#define FSLogWarn(...) {}
#define FSLogError(...) {}

#endif
