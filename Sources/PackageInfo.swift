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

import Foundation
import UIKit

public struct PackageInfo {
    public static var bundle: Bundle? {
        return Bundle(identifier: "com.undev.StartPoint")
    }
}

public struct R {
    public struct image {
        public static func ic_arrow_back() -> UIImage? {
            return _image(name: "ic_arrow_back")
        }

        public static func ic_check() -> UIImage? {
            return _image(name: "ic_check")
        }

        public static func ic_close() -> UIImage? {
            return _image(name: "ic_close")
        }

        public static func ic_more_horiz() -> UIImage? {
            return _image(name: "ic_more_horiz")
        }

        public static func ic_more_vert() -> UIImage? {
            return _image(name: "ic_more_vert")
        }

        public static func ic_refresh() -> UIImage? {
            return _image(name: "ic_refresh")
        }

        private static func _image(name: String) -> UIImage? {
            return UIImage(named: name, in: PackageInfo.bundle, compatibleWith: nil)
        }
    }
}
