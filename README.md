# XXToast
一款易用的 iOS 吐司。

## 参考文档
[]()
中文 | [English](https://github.com/vampire-locker/XXToast/blob/main/README-ENGLISH.md)

## 支持语言
Objective-C

## 支持功能
- 按队列调用和按队列顺序显示；
- 淡入淡出动画；
- 自由的指定显示时长；
- 自由的指定显示位置，有三种位置选择；
- 根据内容长度自动调整显示时长（限定最大和最小显示时长）；
- 点击 toast 关闭。

## 使用方法
1、将文件导入工程，导入代码：
```
#import "XXToast.h"
```

2、不同的调用方式：
```
[XXToast showWithMessage:@"1111"];

[XXToast showWithMessage:@"2222" duration:1.0];

[XXToast showWithMessage:@"3333" position:XXToastPositionCenter];

[XXToast showWithMessage:@"4444" duration:1.0 position:XXToastPositionCenter];
```

## 显示效果
- 单行
![top](https://github.com/vampire-locker/XXToast/blob/main/pic/top-single.png) ![center](https://github.com/vampire-locker/XXToast/blob/main/pic/center-single.png) ![bottom](https://github.com/vampire-locker/XXToast/blob/main/pic/bottom-single.png)

- 多行
![top](https://github.com/vampire-locker/XXToast/blob/main/pic/top-multiple.png) ![center](https://github.com/vampire-locker/XXToast/blob/main/pic/center-multiple.png) ![bottom](https://github.com/vampire-locker/XXToast/blob/main/pic/bottom-multiple.png)