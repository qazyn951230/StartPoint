## StartPoint

**It's a experimental framework. Do not use in product environment.**

**Currently, the "xpm" branch can not build automatically, because it depend on "xpm" (Xcode package manager) which is not available yet.**

---

### JSON

_Available on iOS, macOS_

Unlike other Swift JSON framework, It's implement a UTF-8 (only) JSON decoder. (Because I hate `NSJSONSerialization` and `NSNull`)


```Swift
// Decode a JSON String:
let json = try! JSON.parse("{\"foobar\": 1}")
print(json["foobar"].int == 1)
// true
```

### FlexLayout

_Available on iOS_

A "flexible box" layout engine written in Swift.

```Swift
let box = FlexLayout()
    .alignItems(.center)
    .justifyContent(.center)
let child = FlexLayout()
    .width(.length(10))
    .height(.length(10))
box.append(child)
box.calculate(width: 100, height: 100, direction: .ltr)
box.print(options: .layout)
//<div layout="width: 100.0; height: 100.0; top: 0.0; left: 0.0; " >
//  <div layout="width: 10.0; height: 10.0; top: 45.0; left: 45.0; " ></div>
//</div>
```
### Element

_Available on iOS_

A [Texture](https://github.com/TextureGroup/Texture) like UI interface layer, built top of "FlexLayout".

```Swift
let child = ViewElement()
    .backgroundColor(UIColor.blue)
    .style { flex in
        flex.size(width: 10, height: 10)
    }
let box = ViewElement(children: [child])
    .backgroundColor(UIColor.green)
    .style { flex in
        flex.alignItems(.center).justifyContent(.center)
    }
box.layout(width: 100, height: 100)
let view: UIView = box.buildView()
```

### Permission

_Available on iOS_

Supported Permissions:

* Camera
* Contact
* Location
* Notification
* Photo
* Health
* Motion

Other kinds of permission may add in the future.

```swift
// Check the status of health permission
let status: Driver<Permission> = Permission.status(.health)
status.drive(onNext: { permission in
    // ...
})
```

### Router

_Available on iOS_

### Stream

_Available on iOS, macOS_

### Special thanks

This framework heavily inspired by following projects:

* [rapidjson](https://github.com/Tencent/rapidjson)
* [yoga](https://github.com/facebook/yoga)
* [Texture](https://github.com/TextureGroup/Texture)
* [Permission](https://github.com/delba/Permission)
