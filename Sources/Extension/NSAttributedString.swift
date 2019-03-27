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
#if canImport(UIKit)
import UIKit

public extension NSAttributedString {
    func boundingSize(width: CGFloat, options: NSStringDrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        return boundingSize(size: CGSize(width: width, height: .greatestFiniteMagnitude), options: options)
    }

    func boundingSize(height: CGFloat, options: NSStringDrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        return boundingSize(size: CGSize(width: .greatestFiniteMagnitude, height: height), options: options)
    }

    func boundingSize(size: CGSize = CGSize.max(),
                             options: NSStringDrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        return boundingRect(with: size, options: options, context: nil).size
    }
}
#endif

#if canImport(Cocoa)
import Cocoa

public extension NSAttributedString {
    func boundingSize(width: CGFloat, options: NSString.DrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        return boundingSize(size: CGSize(width: width, height: .greatestFiniteMagnitude), options: options)
    }

    func boundingSize(height: CGFloat, options: NSString.DrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        return boundingSize(size: CGSize(width: .greatestFiniteMagnitude, height: height), options: options)
    }

    func boundingSize(size: CGSize = CGSize.max(),
                             options: NSString.DrawingOptions = [.usesLineFragmentOrigin]) -> CGSize {
        return boundingRect(with: size, options: options, context: nil).size
    }
}
#endif
