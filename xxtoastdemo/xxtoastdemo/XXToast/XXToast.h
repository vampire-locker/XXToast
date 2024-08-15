//
//  XXToast.h
//  SWGameSDK
//
//  Created by apple_new on 2024/8/13.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XXToastPosition) {
    XXToastPositionTop,
    XXToastPositionCenter,
    XXToastPositionBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface XXToast : NSObject


/// show toast, default duration, default middle position
/// - Parameter message: toast message
+ (void)showWithMessage:(NSString *)message;


/// show toast, default middle position
/// - Parameters:
///   - message: toast message
///   - duration: toast duration
+ (void)showWithMessage:(NSString *)message
               duration:(NSTimeInterval)duration;


/// show toast, default duration
/// - Parameters:
///   - message: toast message
///   - position: toast position
+ (void)showWithMessage:(NSString *)message
               position:(XXToastPosition)position;


/// show toast
/// - Parameters:
///   - message: toast message
///   - duration: toast duration
///   - position: toast position
+ (void)showWithMessage:(NSString *)message
               duration:(NSTimeInterval)duration
               position:(XXToastPosition)position;

@end

NS_ASSUME_NONNULL_END
