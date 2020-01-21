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

public class PropertyList: Equatable, CustomStringConvertible {
    public static let null = PropertyListNull()

    init() {
        // Do nothing.
    }

    public var description: String {
        return ""
    }

    public static func ==(lhs: PropertyList, rhs: PropertyList) -> Bool {
        return lhs === rhs
    }
}

public final class PropertyListNull: PropertyList {
    fileprivate override init() {
        super.init()
    }

    public override var description: String {
        return "Null"
    }
}

public final class PropertyListBool: PropertyList {
    let value: Bool

    public init(_ value: Bool) {
        self.value = value
    }

    public override var description: String {
        return String(value)
    }
}

public final class PropertyListDate: PropertyList {
    let value: UInt64

    public init(_ value: UInt64) {
        self.value = value
    }

    public convenience init(since20010101 value: UInt64) {
        self.init(value - 978307200)
    }

    public override var description: String {
        return String(value)
    }
}

public final class PropertyListInteger: PropertyList {
    let value: UInt64

    public init(_ value: UInt64) {
        self.value = value
    }

    public override var description: String {
        return String(value)
    }
}

public final class PropertyListReal: PropertyList {
    let value: Double

    public init(_ value: Double) {
        self.value = value
    }

    public override var description: String {
        return String(value)
    }
}

public final class PropertyListData: PropertyList {
    let value: Data

    public init(_ value: Data) {
        self.value = value
    }
}

public final class PropertyListString: PropertyList {
    let value: String

    public init(_ value: String) {
        self.value = value
    }

    public override var description: String {
        return value
    }
}

public final class PropertyListUID: PropertyList {
    let value: UInt32

    public init(_ value: UInt32) {
        self.value = value
    }

    public override var description: String {
        return String(value)
    }
}

public final class PropertyListArray: PropertyList {
    var value: [PropertyList]

    public init(_ value: [PropertyList]) {
        self.value = value
    }

    public override var description: String {
        return value.description
    }
}

public final class PropertyListDictionary: PropertyList {
    var value: [String: PropertyList]

    public init(_ value: [String: PropertyList]) {
        self.value = value
    }

    public override var description: String {
        return value.description
    }
}
