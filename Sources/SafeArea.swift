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

#if os(iOS)
import UIKit

public struct SafeAreaOption: OptionSet {
    public static let statusBar = SafeAreaOption(rawValue: 1 << 0)
    public static let navigationBar = SafeAreaOption(rawValue: 1 << 1)
    public static let tabBar = SafeAreaOption(rawValue: 1 << 2)
    public static let homeBar = SafeAreaOption(rawValue: 1 << 3)

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct SafeArea {
    private init() {
        // Do nothing.
    }

    public static func safeArea(from viewController: UIViewController) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaInsets + viewController.additionalSafeAreaInsets
        } else {
            return UIEdgeInsets(top: viewController.topLayoutGuide.length, left: 0,
                bottom: viewController.bottomLayoutGuide.length, right: 0)
        }
    }

    public static func safeArea(view: UIView) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }

    // FIXME: Navigation bar or tar bar is translucent
    public static func safeArea(option: SafeAreaOption = [.statusBar, .navigationBar, .tabBar, .homeBar],
                                additional: UIEdgeInsets = UIEdgeInsets.zero) -> UIEdgeInsets {
        let current = UIDevice.current.orientation
        let statusBar: CGFloat = option.contains(.statusBar) ? Device.statusBar : 0
        let navigationBar: CGFloat = option.contains(.navigationBar) ? Device.navigationBar : 0
        let tabBar: CGFloat = option.contains(.tabBar) ? Device.tabBar : 0
        let homeBar: CGFloat = option.contains(.homeBar) ? Device.homeBar : 0
        let x = Device.current.iPhoneX
        let insets: UIEdgeInsets
        if current.isLandscape {
            if x {
                insets = UIEdgeInsets(top: navigationBar, left: 44, bottom: tabBar + homeBar, right: 44)
            } else {
                insets = UIEdgeInsets(top: navigationBar, left: 0, bottom: tabBar, right: 0)
            }
        } else {
            let top = statusBar + navigationBar
            if x {
                insets = UIEdgeInsets(top: top, left: 0, bottom: tabBar + homeBar, right: 0)
            } else {
                insets = UIEdgeInsets(top: top, left: 0, bottom: tabBar, right: 0)
            }
        }
        return insets + additional
    }

    public static func statusBar() -> CGSize {
        return CGSize(width: Device.width, height: Device.statusBar)
    }
}
#endif // #if os(iOS)
