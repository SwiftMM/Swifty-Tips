# ObjectiveC 中的 NS_OPTIONS 转成 swift 中的 OptionSet

```objc
typedef NS_OPTIONS(uint32_t, ObjCOptions) {
    ObjCOptionsUnknown,
    ObjCOptionsOne = 1 << 0,
    ObjCOptionsTwo = 1 << 1,
    ObjCOptionsThree = 1 << 2,
};
```

新建一个类遵循 `OptionSet` 这个协议（可以是结构体或枚举，本例需要供 `ObjectiveC` 调用），实现`init(rawValue: Self.RawValue)`协议方法

```swift
class SwiftOptions: NSObject, OptionSet {
    
    @objc let rawValue: UInt32

    static let unknown = SwiftOptions(rawValue: 0)
    static let ont = SwiftOptions(rawValue: 1 << 0)
    static let two = SwiftOptions(rawValue: 1 << 1)
    static let three = SwiftOptions(rawValue: 1 << 2)
    
    @objc required init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
}
```

在 `ObjectiveC` 中调用

```objc
[[SwiftOptions alloc] initWithRawValue: 1 << 0];
```
