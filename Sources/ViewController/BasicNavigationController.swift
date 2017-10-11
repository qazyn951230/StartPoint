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
import QuartzCore
import CoreGraphics

public enum AppBarStyle {
    case light
    case dark
    case colored(UIColor)
    case transparent
}

// https://developer.android.google.cn/reference/android/view/MenuItem.html
public struct AppMenuItem {
    public let image: UIImage?
    public let title: NSAttributedString?

    var imageSize: CGSize {
        return image?.size ?? CGSize.zero
    }

    public static func backMenuItem() -> AppMenuItem {
        let image: UIImage? = UIImage(named: "ic_arrow_back", in: Bundle(identifier: "com.undev.StartPoint"), compatibleWith: nil)
        return AppMenuItem(image: image, title: nil)
    }

    public static func moreMenuItem() -> AppMenuItem {
        let image: UIImage? = UIImage(named: "ic_more_vert", in: Bundle(identifier: "com.undev.StartPoint"), compatibleWith: nil)
        return AppMenuItem(image: image, title: nil)
    }
}

// https://developer.android.google.cn/guide/topics/resources/menu-resource.html
public struct AppBarItem {
    public var title: String?
    // TODO: largeTitleDisplayMode
    // var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { get set }
    public var navigationItem: AppMenuItem?
    public var menuItem: AppMenuItem?
    public var actionItems: [AppMenuItem]?

    public init() {
        title = nil
        navigationItem = nil
        menuItem = nil
        actionItems = nil
    }
}

open class AppBar: UIView {
    // Size
    public static let appBarLandscapeHeight: CGFloat = 48
    public static let appBarPortraitHeight: CGFloat = 56
    public static let appBarTabletHeight: CGFloat = 64
    public static let statusBarHeight: CGFloat = {
        if case DeviceType.phoneX = Device.current {
            return 44
        }
        return 20
    }()

    // Style
    public var statusBarColor: UIColor? = nil
    public var barColor: UIColor? = nil
    // Property
    public private(set) var appBarItem: AppBarItem? = nil
    public var title: NSAttributedString? {
        get {
            return titleLabel?.attributedText
        }
        set {
            titleLabel?.attributedText = newValue
        }
    }
    // View
    private var statusBarLayer: CALayer? = nil
    private var titleLabel: UILabel? = nil
    private var navigationButton: UIButton? = nil
    private var menuButton: UIButton? = nil
    private var actionButtons: [UIButton] = []
    // Layout
    private var root: FlexLayout = FlexLayout()
    private var barLayout: FlexLayout = FlexLayout()
    private var statusBarLayout: FlexLayout? = nil
    private var titleLayout: FlexLayout? = nil
    private var navigationLayout: FlexLayout? = nil
    private var menuLayout: FlexLayout? = nil
    private var actionLayouts: [FlexLayout]? = nil

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    open func initialization() {
//        appBarItem = AppBarItem()
//        appBarItem?.title = "Title"
//        appBarItem?.navigationItem = AppMenuItem.backMenuItem()
//        appBarItem?.menuItem = AppMenuItem.moreMenuItem()
//        appBarItem?.actionItems = [AppMenuItem.backMenuItem(), AppMenuItem.backMenuItem()]
        initializationView()
        initializationLayout()
    }

    private func initializationView() {
        let barLayer = CALayer()
        layer.addSublayer(barLayer)
        statusBarLayer = barLayer
#if DEBUG
        randomBackgroundColor()
        statusBarLayer?.randomBackgroundColor()
        titleLabel?.randomBackgroundColor()
#endif
        guard let item = appBarItem else {
            return
        }
        if let title = item.title {
            let label = UILabel(frame: CGRect.zero)
            label.attributedText = AttributedString(title)
                .systemFont(17).color(.black).done()
            addSubview(label)
            titleLabel = label
        }
        if let navigation = item.navigationItem {
            let button = UIButton(type: .custom)
            if navigation.image != nil {
                button.setImage(navigation.image, for: .normal)
            } else {
                button.setAttributedTitle(navigation.title, for: .normal)
            }
            addSubview(button)
            navigationButton = button
        }
        if let items = item.actionItems, items.count > 0 {
            for i in items {
                let button = UIButton(type: .custom)
                if i.image != nil {
                    button.setImage(i.image, for: .normal)
                } else {
                    button.setAttributedTitle(i.title, for: .normal)
                }
                addSubview(button)
                actionButtons.append(button)
            }
        }
        if let menu = item.menuItem {
            let button = UIButton(type: .custom)
            if menu.image != nil {
                button.setImage(menu.image, for: .normal)
            } else {
                button.setAttributedTitle(menu.title, for: .normal)
            }
            addSubview(button)
            menuButton = button
        }
    }

    private func initializationLayout() {
        root.bind(view: self)
        // Status Bar Area
        if let bar = statusBarLayer {
            statusBarLayout = root.append(view: bar)
                .width(.match)
                .height(float: AppBar.statusBarHeight)
        }
        // App Bar Area
        barLayout.width(.match)
            .height(float: AppBar.appBarPortraitHeight)
            .flexDirection(.row)
            .alignItems(.flexEnd)
        root.append(barLayout)
        // Navigation Item Area
        let navigationArea = FlexLayout().height(.match).margin(left: 6).justifyContent(.center).width(float: 44)
        barLayout.append(navigationArea)
        if let button = navigationButton {
            navigationArea.append(view: button)
                .width(float: 44).height(float: 44)
        }
        // Title Area
        let titleArea = FlexLayout().flex(1).padding(left: 22).alignItems(.flexStart)
        barLayout.append(titleArea)
        if let title = titleLabel {
            titleLayout = titleArea.append(view: title).margin(bottom: 20)
        }
        // Action Items Area
        let actionsArea = FlexLayout().height(.match).margin(right: 6).alignItems(.center).flexDirection(.row)
        barLayout.append(actionsArea)
        for actionButton in actionButtons {
            actionsArea.append(view: actionButton)
                .width(float: 44).height(float: 44)
        }
        if let button = menuButton {
            actionsArea.append(view: button)
                .width(float: 44).height(float: 44)
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        root.layout(width: Device.width, height: nil)
        root.apply()
        root.debug()
    }
}

open class BasicNavigationController: UIViewController {
    lazy var appBar: AppBar = AppBar(frame: CGRect(origin: .zero, width: Device.width, height: 68))

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appBar)
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
