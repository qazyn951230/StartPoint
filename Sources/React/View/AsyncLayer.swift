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

import QuartzCore
import Dispatch

public protocol AsyncLayerDelegate: class {
    func asyncLayerWillDisplay(_ layer: AsyncLayer)
    func asyncLayer(_ layer: AsyncLayer, display asynchronous: Bool)
    func asyncLayer(_ layer: AsyncLayer, didDisplay finished: Bool)
}

public extension AsyncLayerDelegate {
    public func asyncLayerWillDisplay(_ layer: AsyncLayer) {
        // Do nothing.
    }

    public func asyncLayer(_ layer: AsyncLayer, didDisplay finished: Bool) {
        // Do nothing.
    }
}

public final class AsyncLayer: CALayer {
    @objc public var asynchronous: Bool = true
    weak var _delegate: AsyncLayerDelegate?

    public override init() {
        super.init()
        contentsScale = Device.scale
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override var delegate: CALayerDelegate? {
        didSet {
            _delegate = delegate as? AsyncLayerDelegate
        }
    }

    public override func display() {
        assertMainThread()
        super.contents = super.contents
        display(asynchronous: asynchronous)
    }

    public func display(asynchronous: Bool) {
        assertMainThread()
        _delegate?.asyncLayer(self, display: asynchronous)
    }

    static let displayQueue: DispatchQueue = {
        let target = DispatchQueue.global(qos: .userInitiated)
        return DispatchQueue(label: "com.undev.AsyncLayer.displayQueue",
            attributes: .concurrent, target: target)
    }()

    public override class func defaultValue(forKey key: String) -> Any? {
        if key == #keyPath(AsyncLayer.asynchronous) {
            // TODO: Use NSNumber instead of Bool?
            return true
        }
        return super.defaultValue(forKey: key)
    }
}