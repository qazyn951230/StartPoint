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

import UIKit
import QuartzCore

// ASPrimitiveTraitCollection
public struct TraitCollection: Equatable {
    public let displayScale: CGFloat
    public let containerSize: CGSize
    public let horizontalSizeClass: UIUserInterfaceSizeClass
    public let verticalSizeClass: UIUserInterfaceSizeClass
    public let userInterfaceIdiom: UIUserInterfaceIdiom
    public let forceTouchCapability: UIForceTouchCapability

    public init(displayScale: CGFloat, containerSize: CGSize, horizontalSizeClass: UIUserInterfaceSizeClass,
                verticalSizeClass: UIUserInterfaceSizeClass, userInterfaceIdiom: UIUserInterfaceIdiom,
                forceTouchCapability: UIForceTouchCapability) {
        self.displayScale = displayScale
        self.horizontalSizeClass = horizontalSizeClass
        self.verticalSizeClass = verticalSizeClass
        self.userInterfaceIdiom = userInterfaceIdiom
        self.forceTouchCapability = forceTouchCapability
        self.containerSize = containerSize
    }

    public init(from traitCollection: UITraitCollection, containerSize: CGSize) {
        if #available(iOS 9.0, *) {
            self.init(displayScale: traitCollection.displayScale, containerSize: containerSize,
                horizontalSizeClass: traitCollection.horizontalSizeClass,
                verticalSizeClass: traitCollection.verticalSizeClass,
                userInterfaceIdiom: traitCollection.userInterfaceIdiom,
                forceTouchCapability: traitCollection.forceTouchCapability)
        } else {
            self.init(displayScale: traitCollection.displayScale, containerSize: containerSize,
                horizontalSizeClass: traitCollection.horizontalSizeClass,
                verticalSizeClass: traitCollection.verticalSizeClass,
                userInterfaceIdiom: traitCollection.userInterfaceIdiom,
                forceTouchCapability: .unknown)
        }
    }

    public static let `default` = TraitCollection(displayScale: 0, containerSize: .zero,
        horizontalSizeClass: .unspecified, verticalSizeClass: .unspecified,
        userInterfaceIdiom: .unspecified, forceTouchCapability: .unknown)

    public static func ==(lhs: TraitCollection, rhs: TraitCollection) -> Bool {
        return lhs.horizontalSizeClass == rhs.horizontalSizeClass &&
            lhs.verticalSizeClass == rhs.verticalSizeClass &&
            lhs.displayScale == rhs.displayScale &&
            lhs.userInterfaceIdiom == rhs.userInterfaceIdiom &&
            lhs.forceTouchCapability == rhs.forceTouchCapability &&
            lhs.containerSize == rhs.containerSize
    }
}
