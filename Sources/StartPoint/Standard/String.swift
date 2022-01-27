// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
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

import Foundation // For Data

extension String {
    /// 将任意对象的任意属性转化成 String。一般用于将 C 结构体中的某个属性转化成 String。
    /// C 组数 int[] 在 Swift 中会转化成元组，极其难以使用，因此有个这个帮助方法。
    ///
    /// 比如，获取系统的名称 `utsname.machine` 可以这么写：
    /// ```swift
    /// var raw = utsname()
    /// uname(&raw)
    /// let name = String(raw, keyPath: \utsname.machine, count: Int(_SYS_NAMELEN))
    /// // name = "iPhone14,2"
    /// ```
    ///
    /// - Since: 0.1.1
    /// - Parameters:
    ///   - value: 需要解析的对象，一般为 C 解构体。
    ///   - keyPath: 一个用于读取属性的 KeyPath 对象。
    ///   - count: C 字符串的长度。
    public init?<T>(_ value: T, keyPath: PartialKeyPath<T>, count: Int) {
        guard let offset = MemoryLayout<T>.offset(of: keyPath) else {
            return nil
        }
        let result = withUnsafePointer(to: value) { (pointer: UnsafePointer<T>) -> String? in
            let raw: UnsafeRawPointer = UnsafeRawPointer(pointer).advanced(by: offset)
            let field: UnsafePointer<UInt8> = raw.assumingMemoryBound(to: UInt8.self)
            if field[count - 1] != 0 {
                let data = Data(bytes: raw, count: count)
                return String(data: data, encoding: .utf8)
            } else {
                return String(cString: field)
            }
        }
        if let result = result {
            self = result
        } else {
            return nil
        }
    }
}
