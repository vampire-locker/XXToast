# XXToast
仿 Android 的 iOS 吐司。

## 支持语言
Objective-C

## 支持功能
- 支持按队列调用和按队列顺序显示；
- 支持自由的指定显示时长；
- 支持自由的指定显示位置，有三种选择；
- 支持自动根据内容长度调整显示时长（指定最大和最小显示时长）；
- 支持点击 toast 关闭。

## 使用方法
1、将文件导入工程，导入代码：
```
#import "XXToast.h"
```

2、不同的调用方式：
```
[XXToast showWithMessage:@"1111"];

[XXToast showWithMessage:@"2222" duration:2.0];

[XXToast showWithMessage:@"3333" position:XXToastPositionCenter];

[XXToast showWithMessage:@"4444" duration:2.0 position:XXToastPositionCenter];
```
