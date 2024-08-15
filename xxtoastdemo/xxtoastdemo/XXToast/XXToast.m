//
//  XXToast.m
//  SWGameSDK
//
//  Created by apple_new on 2024/8/13.
//

#import "XXToast.h"
#import <objc/runtime.h>


#pragma mark - Define
// font
#define XXTOAST_FONT_SIZE 14
// duration min
#define XXTOAST_DURATION_MIN 1.5
// duration max
#define XXTOAST_DURATION_MAX 3.0

//@interface XXToast ()<UIGestureRecognizerDelegate>
//
//@end


@implementation XXToast


#pragma mark - Static
// queue(array is ordered)
static NSMutableArray *toastQueue;
// cache
static NSMutableDictionary *heightCache;

// associate gesture
static char kTapGestureKey;
// associated show state
static char kShowStateKey;


#pragma mark - Initialize
// class initialize, which is performed globally only once
+ (void)initialize {
    // initialize the toast queue
    toastQueue = [NSMutableArray array];
    // initialize the toast cache
    heightCache = [NSMutableDictionary dictionary];
}


#pragma mark - Public
// toast show
+ (void)showWithMessage:(NSString *)message {
    [self showWithMessage:message duration:0.0 position:XXToastPositionCenter];
}

+ (void)showWithMessage:(NSString *)message
               duration:(NSTimeInterval)duration {
    [self showWithMessage:message duration:duration position:XXToastPositionCenter];
}

+ (void)showWithMessage:(NSString *)message
               position:(XXToastPosition)position {
    [self showWithMessage:message duration:0.0 position:position];
}

+ (void)showWithMessage:(NSString *)message
               duration:(NSTimeInterval)duration
               position:(XXToastPosition)position {
        
    if (duration == 0.0) {
        NSNumber *cachedHeight = heightCache[message];
        CGFloat textHeight;
        if (cachedHeight) {
            textHeight = [cachedHeight floatValue];
        } else {
            CGSize maxSize = CGSizeMake([self getKeyWindow].bounds.size.width - 40.0 - 20.0, CGFLOAT_MAX);
            CGRect labelRect = [message boundingRectWithSize:maxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:XXTOAST_FONT_SIZE]}
                                                     context:nil];
            textHeight = ceil(labelRect.size.height) + 20.0;
            // add caching to reduce double counting
            heightCache[message] = @(textHeight);
        }
        duration = MAX(XXTOAST_DURATION_MIN, MIN(XXTOAST_DURATION_MAX, textHeight / 20.0));
    }
    
    // set toast info
    NSDictionary *toastInfo = @{
        @"message": message,
        @"duration": @(duration),
        @"position": @(position)
    };
    
    // adds toast info to the queue
    [toastQueue addObject:toastInfo];
    
    // displays if there is only one toast in the queue
    if (toastQueue.count == 1) {
        [self showNextToast];
    }
}


#pragma mark - Private
// next toast show
+ (void)showNextToast {
    
    if (toastQueue.count == 0) {
        // if the queue is empty, exit
        return;
    }

    // get toast info
    NSDictionary *toastInfo = [toastQueue firstObject];
    NSString *message = toastInfo[@"message"];
    NSTimeInterval duration = [toastInfo[@"duration"] doubleValue];
    XXToastPosition position = [toastInfo[@"position"] integerValue];

    UIWindow *window = [self getKeyWindow];
    
    UIView *toastView = [[UIView alloc] init];
    toastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    toastView.layer.cornerRadius = 10;
    toastView.clipsToBounds = YES;
    toastView.userInteractionEnabled = YES;
    
    
    // add a gesture to toast to trigger the closing of toast
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleToastTap:)];
    [toastView addGestureRecognizer:tapGesture];
    // associate the gesture to toastView
    [self setTapGesture:tapGesture forToastView:toastView];
    
    // toast content label
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:XXTOAST_FONT_SIZE];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;

    CGFloat maxWidth = window.bounds.size.width - 40.0;
    CGFloat padding = 10.0;

    CGSize maxSize = CGSizeMake(maxWidth - 2 * padding, CGFLOAT_MAX);
    CGRect labelRect = [message boundingRectWithSize:maxSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: messageLabel.font}
                                             context:nil];

    CGFloat labelWidth = ceil(labelRect.size.width) + 2 * padding;
    CGFloat labelHeight = ceil(labelRect.size.height) + 2 * padding;

    CGFloat yOffset = 0;
    switch (position) {
        case XXToastPositionTop:
            // top position offset
            yOffset = 100.0;
            break;
        case XXToastPositionCenter:
            // middle position offset
            yOffset = (window.bounds.size.height - labelHeight) / 2;
            break;
        case XXToastPositionBottom:
            // bottom position offset
            yOffset = window.bounds.size.height - 100.0 - labelHeight;
            break;
    }

    toastView.frame = CGRectMake((window.bounds.size.width - labelWidth) / 2,
                                 yOffset,
                                 labelWidth,
                                 labelHeight);
    messageLabel.frame = CGRectMake(padding, padding, labelRect.size.width, labelRect.size.height);
    [toastView addSubview:messageLabel];
    [window addSubview:toastView];
    // associate the display status to toastView
    [self setShowState:YES forToastView:toastView];
    
    __weak typeof(self) weakSelf = self;
    // toast fade in animation
    // 'UIViewAnimationOptionAllowUserInteraction' gesture behavior during animation is allowed
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        toastView.alpha = 1.0;
    } completion:^(BOOL finished) {
        // toast fade out animation
        [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionAllowUserInteraction animations:^{
            // toastView.alpha = 0.01; using this will disable the gesture
            toastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            // remove the toast view
            [weakSelf removeToastView:toastView];
        }];
    }];
}

// get the current main (topmost) window.
+ (UIWindow *)getKeyWindow {
    UIWindow *keyWindow = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window.isKeyWindow) {
                keyWindow = window;
                break;
            }
        }
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return keyWindow;
}

// handling click events
+ (void)handleToastTap:(UITapGestureRecognizer *)recognizer {
    
    UIWindow *window = [self getKeyWindow];
    UIView *toastView = [window.subviews lastObject];
    
    if ([self getTapGestureForToastView:toastView]) {
        [self setTapGesture:nil forToastView:toastView];
    }
    
    if ([self getShowStateForToastView:toastView]) {
        // no animation is needed here because the second animateWithDuration of the toastView in the showNextToast method is executed when the toastView is removed
        [toastView removeFromSuperview];
        [self setShowState:NO forToastView:toastView];
    }
    
}

// remove the toast view
+ (void)removeToastView:(UIView *)toastView {
    
    UITapGestureRecognizer *tapGesture = [self getTapGestureForToastView:toastView];
    if (tapGesture) {
        [toastView removeGestureRecognizer:tapGesture];
        [self setTapGesture:nil forToastView:toastView];
    }
    
    if ([self getShowStateForToastView:toastView]) {
        [toastView removeFromSuperview];
        [self setShowState:NO forToastView:toastView];
    }
    
    if (toastQueue.count > 0) {
        [toastQueue removeObjectAtIndex:0];
    }
    
    [self showNextToast];
    
}


#pragma mark - Property binding
// associate gesture
+ (void)setTapGesture:(UITapGestureRecognizer *)tapGesture forToastView:(UIView *)toastView {
    objc_setAssociatedObject(toastView, &kTapGestureKey, tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UITapGestureRecognizer *)getTapGestureForToastView:(UIView *)toastView {
    return objc_getAssociatedObject(toastView, &kTapGestureKey);
}

// associated show state
+ (void)setShowState:(BOOL)exit forToastView:(UIView *)toastView {
    NSNumber *value = [NSNumber numberWithBool:exit];
    objc_setAssociatedObject(toastView, &kShowStateKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)getShowStateForToastView:(UIView *)toastView {
    NSNumber *value = objc_getAssociatedObject(toastView, &kShowStateKey);
    return [value boolValue];
}


@end

