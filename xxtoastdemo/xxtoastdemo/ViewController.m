//
//  ViewController.m
//  xxtoastdemo
//
//  Created by apple_new on 2024/8/14.
//

#import "ViewController.h"
#import "XXToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [XXToast showWithMessage:@"1111"];
    [XXToast showWithMessage:@"2222" duration:1.0];
    [XXToast showWithMessage:@"3333" position:XXToastPositionCenter];
    [XXToast showWithMessage:@"4444" duration:1.0 position:XXToastPositionCenter];
}


@end
