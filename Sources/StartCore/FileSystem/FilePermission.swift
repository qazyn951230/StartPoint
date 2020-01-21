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

public struct FilePermission: OptionSet {
    public typealias RawValue = UInt16

    public let rawValue: UInt16

    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }

    public init(_ value: UInt16) {
        rawValue = value
    }

    public static let none = FilePermission(0o0000)
    public static let ownerRead = FilePermission(0o0400)
    public static let ownerWrite = FilePermission(0o0200)
    public static let ownerExecute = FilePermission(0o0100)
    public static let ownerAll = FilePermission(0o0700)
    public static let groupRead = FilePermission(0o0040)
    public static let groupWrite = FilePermission(0o0020)
    public static let groupExecute = FilePermission(0o0010)
    public static let groupAll = FilePermission(0o0070)
    public static let othersRead = FilePermission(0o0004)
    public static let othersWrite = FilePermission(0o0002)
    public static let othersExecute = FilePermission(0o0001)
    public static let othersAll = FilePermission(0o0007)
    public static let read = FilePermission(0o0444)
    public static let write = FilePermission(0o0222)
    public static let execute = FilePermission(0o0111)
    public static let setUserId = FilePermission(0o4000)
    public static let setGroupId = FilePermission(0o2000)
    public static let stickyBit = FilePermission(0o1000)
    public static let all = FilePermission(0o0777)
    public static let mask = FilePermission(0o7777)
    public static let unknown = FilePermission(0xffff)
}
