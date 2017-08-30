# ConstraintChecker

[![CI Status](http://img.shields.io/travis/willice9527/ConstraintChecker.svg?style=flat)](https://travis-ci.org/willice9527/ConstraintChecker)
[![Version](https://img.shields.io/cocoapods/v/ConstraintChecker.svg?style=flat)](http://cocoapods.org/pods/ConstraintChecker)
[![License](https://img.shields.io/cocoapods/l/ConstraintChecker.svg?style=flat)](http://cocoapods.org/pods/ConstraintChecker)
[![Platform](https://img.shields.io/cocoapods/p/ConstraintChecker.svg?style=flat)](http://cocoapods.org/pods/ConstraintChecker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
![MantleDemo~](https://github.com/willice9527/ConstraintChecker/blob/master/ConstraintChecker.gif)

## Requirements
1. A tool that help you find ambiguous constraint automatically,just install it(only in debug mode will be much safer),no extra configration needed;
2. Once any ambiguous constraints discoverd,a flashing button will appeared on top of the screen.Click it will log all infomation to console which will be great help for identify the problem,meanwhile the condemned view will be marked with red border.
3. Only the view hierarchy being diplayed will be checked.

## Installation

ConstraintChecker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ConstraintChecker"
```

## Author

willice9527, nwpu_liuzhou@163.com

## License

ConstraintChecker is available under the MIT license. See the LICENSE file for more info.
