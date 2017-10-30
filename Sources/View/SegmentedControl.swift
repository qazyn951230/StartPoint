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

import UIKit

// https://github.com/dzenbot/DZNSegmentedControl/blob/master/Source/DZNSegmentedControl.m
public final class SegmentedControl: FlexControl {
    private var buttons: [UIButton] = []

    public var selectedSegmentIndex: Int = 0 {
        didSet {
            buttons.forEachIndex { (button, index) in
                button.isSelected = index == selectedSegmentIndex
            }
        }
    }

    public override func initialization() {
        root.margin(vertical: 2).flexDirection(.row).justifyContent(.spaceBetween)
    }

    public func setTitle(_ title: NSAttributedString?, forSegmentAt index: Int) {
        let button = buttons.object(at: index)
        button?.setAttributedTitle(title, for: .normal)
    }
}
