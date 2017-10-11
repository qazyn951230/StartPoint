//
// Created by Nan Yang on 2017/10/9.
// Copyright (c) 2017 Nan Yang. All rights reserved.
//

import QuartzCore
import UIKit

public protocol LayoutView: class {
    var frame: CGRect { get set }
    var measureSelf: Bool { get }
    func sizeThatFits(_ size: CGSize) -> CGSize
}

extension UIView: LayoutView {
    public var measureSelf: Bool {
        return true
    }
}

extension CALayer: LayoutView {
    public var measureSelf: Bool {
        return false
    }

    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return preferredFrameSize()
    }
}
