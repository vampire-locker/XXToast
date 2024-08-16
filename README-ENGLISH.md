# XXToast
An easy-to-use iOS toast.

## Documentation
[Chinese](https://github.com/vampire-locker/XXToast/blob/main/README.md) | English

## Supporting Language
Objective-C

## Supporting Features
- Automatically displayed in queue order when called;
- Fade in and out animations;
- Freely specified display duration;
- Freely specify the display position, there are three position choices;
- Automatically adjust display duration based on content length (limit maximum and minimum display duration);
- Click toast to close.

## How to Use
1. Import the file into the project and import the code:
```
#import "XXToast.h"
```

2. Different calling methods:
```
[XXToast showWithMessage:@"1111"];

[XXToast showWithMessage:@"2222" duration:1.0];

[XXToast showWithMessage:@"3333" position:XXToastPositionCenter];

[XXToast showWithMessage:@"4444" duration:1.0 position:XXToastPositionCenter];
```

## Display Effect
- Single line

![top](https://github.com/vampire-locker/XXToast/blob/main/pic/top-single.png) ![center](https://github.com/vampire-locker/XXToast/blob/main/pic/center-single.png) ![bottom](https://github.com/vampire-locker/XXToast/blob/main/pic/bottom-single.png)

- Multiple line

![top](https://github.com/vampire-locker/XXToast/blob/main/pic/top-multiple.png) ![center](https://github.com/vampire-locker/XXToast/blob/main/pic/center-multiple.png) ![bottom](https://github.com/vampire-locker/XXToast/blob/main/pic/bottom-multiple.png)