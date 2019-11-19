# TiercelObjCBridge
现在，只需要集成 TiercelObjCBridge ，就可以在 Objective-C 上使用 Tiercel 了。Tiercel 是纯 Swift 编写的，里面使用了一些 Swift 的特性，导致无法直接在 Objective-C 上使用，而 TiercelObjCBridge 做了一些中间处理，可以让开发者在 Objective-C 上使用 Tiercel ，但也意味会带来更高的开销成本，更低的效率。TiercelObjCBridge 将Tiercel 上大部分功能都做了转换处理，但由于语言的差异，存在某些功能目前没有实现。



## 环境要求

- iOS 8.0+
- Xcode 10.2+
- Swift 5.0+



## 安装

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TiercelObjCBridge'
end
```

