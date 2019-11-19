# TiercelObjCBridge

[![Version](https://img.shields.io/cocoapods/v/TiercelObjCBridge.svg?style=flat)](http://cocoapods.org/pods/TiercelObjCBridge)
[![Platform](https://img.shields.io/cocoapods/p/TiercelObjCBridge.svg?style=flat)](http://cocoapods.org/pods/TiercelObjCBridge)
[![Language](https://img.shields.io/badge/language-swift-red.svg?style=flat)]()
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-brightgreen.svg?style=flat)](https://www.apple.com/nl/ios/)
[![License](https://img.shields.io/cocoapods/l/TiercelObjCBridge.svg?style=flat)](http://cocoapods.org/pods/TiercelObjCBridge)

TiercelObjCBridge 是使用 Swift 编写的 Tiercel 桥接扩展，只要使用 TiercelObjCBridge ，就可以在 Objective-C 上使用 Tiercel 

由于 Tiercel 是纯 Swift 编写的，里面使用了一些 Swift 的特性，导致无法直接在 Objective-C 上使用，而 TiercelObjCBridge 做了一些中间处理，可以让开发者在 Objective-C 上使用 Tiercel ，但也意味会带来更高的开销成本，更低的效率。TiercelObjCBridge 将 Tiercel 上大部分功能都做了转换处理，用法和原来的 Tiercel 接近，基本满足大部分开发需求，只是由于语言的差异，存在某些功能目前没有实现



## 环境要求

- iOS 8.0+
- Xcode 10.2+
- Swift 5.0+



## 安装

### CocoaPods

TiercelObjCBridge 支持 CocoaPods 集成，首先需要使用以下命令安装CocoaPod：

```bash
$ gem install cocoapods
```

在`Podfile`文件中

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TiercelObjCBridge'
end
```

最后运行命令

```bash
$ pod install
```



## Demo

- TiercelObjCBridge 依赖 Tiercel，所以运行 Demo 需要先下载 Tiercel 项目

- 打开 TiercelObjCBridge 项目文件夹里面的`TiercelObjCBridge.xcworkspace`文件，点击菜单栏的`File`，选择`Add Files To "TiercelObjCBridge"...` ，把 Tiercel 项目中`Tiercel.xcodeproj`添加进去
- 按顺序编译`Tiercel` Target、`TiercelObjCBridge` Target，最后就可以运行 Demo



## 用法

TiercelObjCBridge 只是提供了桥接，本质上还是使用 Tiercel，所以在 Objective-C 上的用法和原版的用法基本一样，具体用法可以参考本项目的 Demo 和 Tiercel 的Demo。唯一注意点就是导入的方式，在需要使用 Tiercel 的文件加上以下这句宏即可

```objective-c
#import <TiercelObjCBridge/TiercelObjCBridge-Swift.h>
```



## License

TiercelObjCBridge is available under the MIT license. See the LICENSE file for more info.