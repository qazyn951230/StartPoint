//
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

public struct R {
    public struct image {
        public static func ic_arrow_back() -> UIImage? {
            _image(name: "ic_arrow_back")
        }

        public static func ic_arrow_downward() -> UIImage? {
            _image(name: "ic_arrow_downward")
        }

        public static func ic_arrow_forward() -> UIImage? {
            _image(name: "ic_arrow_forward")
        }

        public static func ic_arrow_upward() -> UIImage? {
            _image(name: "ic_arrow_upward")
        }

        public static func ic_check() -> UIImage? {
            _image(name: "ic_check")
        }

        public static func ic_close() -> UIImage? {
            _image(name: "ic_close")
        }

        public static func ic_more_horiz() -> UIImage? {
            _image(name: "ic_more_horiz")
        }

        public static func ic_more_vert() -> UIImage? {
            _image(name: "ic_more_vert")
        }

        public static func ic_refresh() -> UIImage? {
            _image(name: "ic_refresh")
        }

        public static func ic_chevron_left() -> UIImage? {
            _image(name: "ic_chevron_left")
        }

        public static func ic_chevron_right() -> UIImage? {
            _image(name: "ic_chevron_right")
        }

        private static func _image(name: String) -> UIImage? {
            UIImage(named: name, in: PackageInfo.bundle, compatibleWith: nil)
        }
    }
}
#endif // #if os(iOS)
