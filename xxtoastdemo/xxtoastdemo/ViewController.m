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
    [XXToast showWithMessage:@"6666" duration:4.0 position:XXToastPositionCenter];
    [XXToast showWithMessage:@"666666666666" duration:2.0 position:XXToastPositionCenter];
    [XXToast showWithMessage:@"666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666" duration:0.0 position:XXToastPositionCenter];
}


@end
