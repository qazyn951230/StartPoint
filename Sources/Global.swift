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

public func match<T>(v4: T, v5: T, v6: T, v6p: T, x: T) -> T {
    switch Device.current {
    case .phone4:
        return v4
    case .phone5:
        return v5
    case .phone6:
        return v6
    case .phone6Plus:
        return v6p
    case .phoneX:
        return x
    }
}

public func match<T>(v4: T?, v5: T?, v6: T?, v6p: T?, x: T?) -> T? {
    switch Device.current {
    case .phone4:
        return v4
    case .phone5:
        return v5
    case .phone6:
        return v6
    case .phone6Plus:
        return v6p
    case .phoneX:
        return x
    }
}

public func match<T>(v4: T, v5: T, v6: T, v6p: T) -> T {
    switch Device.current {
    case .phone4:
        return v4
    case .phone5:
        return v5
    case .phone6:
        return v6
    case .phone6Plus, .phoneX:
        return v6p
    }
}

public func match<T>(v4: T?, v5: T?, v6: T?, v6p: T?) -> T? {
    switch Device.current {
    case .phone4:
        return v4
    case .phone5:
        return v5
    case .phone6:
        return v6
    case .phone6Plus, .phoneX:
        return v6p
    }
}

public func match<T>(v5: T, v6: T, v6p: T) -> T {
    switch Device.current {
    case .phone4, .phone5:
        return v5
    case .phone6:
        return v6
    case .phone6Plus, .phoneX:
        return v6p
    }
}

public func match<T>(v5: T?, v6: T?, v6p: T?) -> T? {
    switch Device.current {
    case .phone4, .phone5:
        return v5
    case .phone6:
        return v6
    case .phone6Plus, .phoneX:
        return v6p
    }
}

public func match<T>(v320: T, v375: T, v414: T) -> T {
    switch Device.current {
    case .phone4, .phone5:
        return v320
    case .phone6, .phoneX:
        return v375
    case .phone6Plus:
        return v414
    }
}

public func match<T>(v320: T?, v375: T?, v414: T?) -> T? {
    switch Device.current {
    case .phone4, .phone5:
        return v320
    case .phone6, .phoneX:
        return v375
    case .phone6Plus:
        return v414
    }
}

public func match<T>(v5: T, v6: T) -> T {
    switch Device.current {
    case .phone4, .phone5:
        return v5
    case .phone6, .phone6Plus, .phoneX:
        return v6
    }
}

public func match<T>(v5: T?, v6: T?) -> T? {
    switch Device.current {
    case .phone4, .phone5:
        return v5
    case .phone6, .phone6Plus, .phoneX:
        return v6
    }
}

public func within<T:Comparable>(_ value: T, min: T, max: T) -> T {
    return Swift.max(min, Swift.min(value, max))
}
