//
// Created by Nan Yang on 2017/10/9.
// Copyright (c) 2017 Nan Yang. All rights reserved.
//

import QuartzCore
import UIKit

public protocol LayoutView: class {
    var frame: CGRect { get set }
    var measureSelf: Bool { get }
    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size
}

extension UIView: LayoutView {
    public var measureSelf: Bool {
        return true
    }

    public func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        let size = sizeThatFits(CGSize(width: width, height: height))
        return Size(cgSize: size)
    }
}

extension CALayer: LayoutView {
    public var measureSelf: Bool {
        return false
    }

    public func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        return Size(cgSize: preferredFrameSize())
    }
}
