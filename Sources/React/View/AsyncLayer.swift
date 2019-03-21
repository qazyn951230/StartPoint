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
import UIKit

public protocol AsyncLayerTask {
    var layer: AsyncLayer { get }

    func willDisplay()
    func display(cancelled: () -> Bool) -> UIImage?
    func didDisplay(finished: Bool)
}

public extension AsyncLayerTask {
    public func willDisplay() {
        // Do nothing.
    }

    public func didDisplay(finished: Bool) {
        // Do nothing.
    }
}

public protocol AsyncLayerDelegate: class {
    func asyncLayerDisplayTask(for layer: AsyncLayer) -> AsyncLayerTask
}

public final class AsyncLayer: CALayer {
    @objc public var asynchronous: Bool = false
    private weak var _delegate: AsyncLayerDelegate?
    private let version: UnsafeMutablePointer<Int>

    public override init() {
        version = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        version.initialize(to: 0)
        super.init()
    }

    public required init?(coder aDecoder: NSCoder) {
        version = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        version.initialize(to: 0)
        super.init(coder: aDecoder)
    }

    deinit {
        version.pointee += 1
        version.deallocate()
    }

    public override var delegate: CALayerDelegate? {
        didSet {
            _delegate = delegate as? AsyncLayerDelegate
        }
    }

    public override func setNeedsDisplay() {
        cancelAsyncDisplay()
        super.setNeedsDisplay()
    }

    public override func display() {
        assertMainThread()
        // clean `setNeedsDisplay`
        super.contents = super.contents
        display(asynchronous: asynchronous)
    }

    public func display(asynchronous: Bool) {
        assertMainThread()
        guard let task = _delegate?.asyncLayerDisplayTask(for: self) else {
            return
        }
        if asynchronous {
            let version = self.version
            let _version = self.version.pointee
            let cancelled: () -> Bool = {
                _version != version.pointee
            }
            AsyncLayer.displayQueue.async { [weak self] in
                guard let this = self else {
                    return
                }
                AsyncLayer.runTask(layer: this, task: task, cancelled: cancelled)
            }
        } else {
            cancelAsyncDisplay()
            AsyncLayer.runTask(layer: self, task: task)
        }
    }

    public func cancelAsyncDisplay() {
        version.pointee += 1
    }

    static let displayQueue: DispatchQueue = {
        let target = DispatchQueue.global(qos: .userInitiated)
        return DispatchQueue(label: "com.undev.AsyncLayer.displayQueue",
            attributes: .concurrent, target: target)
    }()

    public override class func defaultValue(forKey key: String) -> Any? {
        if key == #keyPath(AsyncLayer.asynchronous) {
            return false
        }
        return super.defaultValue(forKey: key)
    }

    private static func runTask(layer: AsyncLayer, task: AsyncLayerTask) {
        task.willDisplay()
        let rawImage = task.display() {
            false
        }
        if let image = rawImage {
            layer.contents = image.cgImage
            task.didDisplay(finished: true)
        } else {
#if DEBUG
            Log.error("AsyncLayerTask drawn nothing.")
#endif
        }
    }

    private static func runTask(layer: AsyncLayer, task: AsyncLayerTask, cancelled: () -> Bool) {
        if cancelled() {
            return
        }
        task.willDisplay()
        if cancelled() {
            task.didDisplay(finished: false)
            return
        }
        let rawImage = task.display(cancelled: cancelled)
        if cancelled() {
            task.didDisplay(finished: false)
            return
        }
        if let image = rawImage {
            if cancelled() {
                task.didDisplay(finished: false)
            } else {
                layer.contents = image.cgImage
                task.didDisplay(finished: true)
            }
        } else {
#if DEBUG
            Log.error("AsyncLayerTask drawn nothing.")
#endif
        }
    }
}
