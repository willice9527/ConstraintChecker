# ConstraintChecker

[![CI Status](http://img.shields.io/travis/willice9527/ConstraintChecker.svg?style=flat)](https://travis-ci.org/willice9527/ConstraintChecker)
[![Version](https://img.shields.io/cocoapods/v/ConstraintChecker.svg?style=flat)](http://cocoapods.org/pods/ConstraintChecker)
[![License](https://img.shields.io/cocoapods/l/ConstraintChecker.svg?style=flat)](http://cocoapods.org/pods/ConstraintChecker)
[![Platform](https://img.shields.io/cocoapods/p/ConstraintChecker.svg?style=flat)](http://cocoapods.org/pods/ConstraintChecker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Demo

The demo here is simple with issue which quite easy to find.But ambiguous constraint in your real project could be much more obscure and sometimes may even act as you expected, with this tool, it will help you to identify them automatically before they become real problem.

这个示例比较简单，一眼就可以发现问题。但是真实项目中由于页面元素多且复杂，往往难以发现。并且有些情况下，即便有这个问题，也不一定会出现显示上的异常。即出现多种可能，但目前版本下计算结果相同。这种问题暂时可能不会有什么影响，但一旦系统更新，有时候就会爆发出来。这个工具可以帮你轻松实现监控并定位有问题的视图。

![MantleDemo~](https://github.com/willice9527/ConstraintChecker/blob/master/ConstraintChecker.gif)

## Requirements
1. A tool that help you find ambiguous constraint automatically,just install it(only in debug mode will be much safer),no extra configration needed;
  仅需通过Pod安装，无需任何配置，强烈建议只在DEBUG下安装

2. Once any ambiguous constraints discoverd,a flashing button will appeared on top of the screen.Click it will log all infomation to console which will be great help for identifying the problem,meanwhile the condemned view will be marked with red border.
  一旦检测到问题，即会在顶部右上角显示一个闪动的按钮，点击可在console窗口查看详细信息。并且有问题的视图会用红色边框标记出来。

3. Only the view hierarchy being diplayed will be checked.
  只有当前展示的视图会被检查，即当前key window的所有视图元素
  

## Installation

ConstraintChecker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ConstraintChecker",   :configurations => ['Debug']
```

## Author

willice9527, nwpu_liuzhou@163.com

## License

ConstraintChecker is available under the MIT license. See the LICENSE file for more info.
