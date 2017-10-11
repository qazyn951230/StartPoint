// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

import UIKit

public enum DeviceSystem {
    case iOS
    case macOS
    case tvOS
    case watchOS
}

public enum DeviceType {
    case phone4 // 640 x 960; @2x; 326 ppi
    case phone5 // 640 x 1136; @2x; 326 ppi
    case phone6 // 750 x 1134; @2x; 326 ppi
    case phone6Plus // 1242 x 2208; @3x; 401 ppi
    case phoneX // 2436 x 1125; @3x; 458 ppi
//    case pad // 1024 x 768; @1x; 132 ppi
//    case padRetina // 2048 x 1536; @2x; mini 326 ppi; 9.7 264 ppi
//    case padPro105 // 2224 x 1668; @2x; 264 ppi
//    case padPro129 // 2732 x 2048; @2x; 264 ppi
//    case watch38 // 272 x 340; @2x
//    case watch42 // 312 x 390; @2x
}

public enum DeviceVersion: Int {
    case version80 = 0
    case version81
    case version82
    case version83
    case version84
    case version90
    case version91
    case version92
    case version93
    case version100
    case version101
    case version102
    case version103
    case version110
    case version111
}

public struct Device {
    public static let current: DeviceType = {
        let size = Device.size
        let height = size.height > size.width ? size.height : size.width
        if height > 736 { // 2436 * 1125 / 812 * 375
            return DeviceType.phoneX
        } else if height > 667 { // 1242 * 2208 / 414 * 736
            return DeviceType.phone6Plus
        } else if height > 568 { // 750 * 1334 / 375 * 667
            return DeviceType.phone6
        } else if height > 480 { // 640 * 1136 / 320 * 568
            return DeviceType.phone5
        } else { // 640 * 960 / 320 * 480
            return DeviceType.phone4
        }
    }()

    public static let version: DeviceVersion = {
        guard let v = Double(UIDevice.current.systemVersion) else {
            return DeviceVersion.version80
        }
        if v > 10.99 {
            if v > 11.09  {
                return DeviceVersion.version111
            } else {
                return DeviceVersion.version110
            }
        } else if v > 9.99 {
            if v > 10.29 {
                return DeviceVersion.version103
            } else if v > 10.19 {
                return DeviceVersion.version102
            } else if v > 10.09  {
                return DeviceVersion.version101
            } else {
                return DeviceVersion.version100
            }
        } else if v > 8.99 {
            if v > 9.29 {
                return DeviceVersion.version93
            } else if v > 9.19 {
                return DeviceVersion.version92
            } else if v > 9.09  {
                return DeviceVersion.version91
            } else {
                return DeviceVersion.version90
            }
        } else {
            if v > 8.39 {
                return DeviceVersion.version84
            } else if v > 8.29 {
                return DeviceVersion.version83
            } else if v > 8.19 {
                return DeviceVersion.version82
            } else if v > 8.09  {
                return DeviceVersion.version81
            } else {
                return DeviceVersion.version80
            }
        }
    }()

    public static let size: CGSize = UIScreen.main.bounds.size
    public static let width: CGFloat = size.width
    public static let height: CGFloat = size.height
}
