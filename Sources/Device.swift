// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS)
import UIKit

public enum DeviceSystem {
    case iOS
    case macOS
    case tvOS
    case watchOS
}

// See also: https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
public enum DeviceType {
    case phone4         // 320 × 480
    case phone5         // 320 × 568
    case phone6         // 375 × 667
    case phone6Plus     // 414 × 736
    case phoneX         // 375 × 812
    case phoneMAX       // 414 × 896

    public var iPhoneX: Bool {
        return self == DeviceType.phoneX || self == DeviceType.phoneMAX
    }

    public var unsafe: Bool {
        return self == DeviceType.phoneX || self == DeviceType.phoneMAX
    }
}

public enum DeviceVersion: Int {
    case version90 = 0
    case version91
    case version92
    case version93
    case version100
    case version101
    case version102
    case version103
    case version110
    case version111
    case version112
    case version113
    case version120
    case version121

    public static func <(lhs: DeviceVersion, rhs: DeviceVersion) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public static func >(lhs: DeviceVersion, rhs: DeviceVersion) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }

    public static func <=(lhs: DeviceVersion, rhs: DeviceVersion) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }

    public static func >=(lhs: DeviceVersion, rhs: DeviceVersion) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
}

public struct Device {
    public static let current: DeviceType = {
        let size = Device.size
        let height = size.height > size.width ? size.height : size.width
        if height > 813 {
            return DeviceType.phoneMAX
        } else if height > 737 {
            return DeviceType.phoneX
        } else if height > 668 {
            return DeviceType.phone6Plus
        } else if height > 569 {
            return DeviceType.phone6
        } else if height > 481 {
            return DeviceType.phone5
        } else {
            return DeviceType.phone4
        }
    }()

    public static let version: DeviceVersion = {
        // 11.2.1 is valid version
        let s = UIDevice.current.systemVersion
        let array: [Substring] = s.split(separator: ".")
        let c: String
        if array.count > 2 {
            c = String(array[0] + "." + array[1])
        } else {
            c = s
        }
        guard let v = Double(c) else {
            return DeviceVersion.version90
        }
        if v > 11.99 {
            if v > 12.09 {
                return DeviceVersion.version121
            } else {
                return DeviceVersion.version120
            }
        } else if v > 10.99 {
            if v > 11.29 {
                return DeviceVersion.version113
            } else if v > 11.19 {
                return DeviceVersion.version112
            } else if v > 11.09 {
                return DeviceVersion.version111
            } else {
                return DeviceVersion.version110
            }
        } else if v > 9.99 {
            if v > 10.29 {
                return DeviceVersion.version103
            } else if v > 10.19 {
                return DeviceVersion.version102
            } else if v > 10.09 {
                return DeviceVersion.version101
            } else {
                return DeviceVersion.version100
            }
        } else {
            if v > 9.29 {
                return DeviceVersion.version93
            } else if v > 9.19 {
                return DeviceVersion.version92
            } else if v > 9.09 {
                return DeviceVersion.version91
            } else {
                return DeviceVersion.version90
            }
        }
    }()

    public static let size: CGSize = UIScreen.main.bounds.size
    public static let width: CGFloat = size.width
    public static let height: CGFloat = size.height
    public static let scale: CGFloat = UIScreen.main.scale

    public static var landscape: Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }

    public static var portrait: Bool {
        return !landscape
    }

    public static var statusBar: CGFloat {
        guard portrait else {
            return 0
        }
        return current.iPhoneX ? 44 : 20
    }

    public static var navigationBar: CGFloat {
        return portrait ? 44 : 32
    }

    public static var tabBar: CGFloat {
        return portrait ? 49 : 32
    }

    public static var homeBar: CGFloat {
        guard current.iPhoneX else {
            return 0
        }
        return portrait ? 34 : 21
    }
}
#endif // os(iOS)
