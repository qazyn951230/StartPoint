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

// ASHierarchyState
public struct HierarchyState: OptionSet {
    // union x|y
    // intersection x&y
    // subtracting ~x
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let rasterized = HierarchyState(rawValue: 1 << 0)
    public static let rangeManaged = HierarchyState(rawValue: 1 << 1)
    public static let transitioningSuperElement = HierarchyState(rawValue: 1 << 2)
    public static let layoutPending = HierarchyState(rawValue: 1 << 3)

    public static let all: HierarchyState = [HierarchyState.rasterized, .rangeManaged,
                                             .transitioningSuperElement, .layoutPending]

    internal var _rasterized: Bool {
        return contains(.rasterized)
    }

    internal var _rangeManaged: Bool {
        return contains(.rangeManaged)
    }

    internal var _transitioningSuperElement: Bool {
        return contains(.transitioningSuperElement)
    }

    internal var _layoutPending: Bool {
        return contains(.layoutPending)
    }
}
