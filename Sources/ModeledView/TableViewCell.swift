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

public class DefaultTableViewCell: UITableViewCell {
    public static let identifier: String = "DefaultTableViewCell"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: DefaultTableViewCell.identifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func fulfill(_ model: Any) {
        guard let model = model as? DefaultTableViewCellModel else {
            return
        }
        textLabel?.attributedText = model.title
        imageView?.image = model.image ?? model.imageName.flatMap(UIImage.init(named:))
        accessoryType = model.accessory
        selectionStyle = model.selectionStyle
    }
}

public struct DefaultTableViewCellModel: HeightViewModel {
    public var height: CGFloat = 44
    public var identifier: String = DefaultTableViewCell.identifier

    public var title: NSAttributedString? = nil
    public var imageName: String? = nil
    public var image: UIImage? = nil
    public var accessory: UITableViewCellAccessoryType

    public var selectionStyle: UITableViewCellSelectionStyle

    public init() {
        self.init(accessory: .disclosureIndicator, selection: true)
    }

    public init(accessory: UITableViewCellAccessoryType, selection: Bool) {
        self.accessory = accessory
        selectionStyle = selection ? .default : .none
    }
}

public class SubtitleTableViewCell: UITableViewCell {
    public static let identifier: String = "SubtitleTableViewCell"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: SubtitleTableViewCell.identifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func fulfill(_ model: Any) {
        guard let model = model as? SubtitleTableViewCellModel else {
            return
        }
        textLabel?.attributedText = model.title
        detailTextLabel?.attributedText = model.subtitle
        detailTextLabel?.numberOfLines = model.subtitleLines
        imageView?.image = model.image ?? model.imageName.flatMap(UIImage.init(named:))
        accessoryType = model.accessory
        selectionStyle = model.selectionStyle
    }
}

public struct SubtitleTableViewCellModel: HeightViewModel {
    public var height: CGFloat = 44
    public var identifier: String = SubtitleTableViewCell.identifier

    public var title: NSAttributedString? = nil
    public var subtitle: NSAttributedString? = nil
    public var imageName: String? = nil
    public var image: UIImage? = nil
    public var accessory: UITableViewCellAccessoryType

    public var subtitleLines: Int = 0
    public var selectionStyle: UITableViewCellSelectionStyle

    public init() {
        self.init(accessory: .disclosureIndicator, selection: true)
    }

    public init(accessory: UITableViewCellAccessoryType, selection: Bool) {
        self.accessory = accessory
        selectionStyle = selection ? .default : .none
    }
}

public class Value1TableViewCell: UITableViewCell {
    public static let identifier: String = "Value1TableViewCell"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: Value1TableViewCell.identifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func fulfill(_ model: Any) {
        guard let model = model as? Value1TableViewCellModel else {
            return
        }
        textLabel?.attributedText = model.title
        detailTextLabel?.attributedText = model.subtitle
        detailTextLabel?.numberOfLines = model.subtitleLines
        imageView?.image = model.image ?? model.imageName.flatMap(UIImage.init(named:))
        accessoryType = model.accessory
        selectionStyle = model.selectionStyle
    }
}

public struct Value1TableViewCellModel: HeightViewModel {
    public var height: CGFloat = 44
    public var identifier: String = Value1TableViewCell.identifier

    public var title: NSAttributedString? = nil
    public var subtitle: NSAttributedString? = nil
    public var imageName: String? = nil
    public var image: UIImage? = nil
    public var accessory: UITableViewCellAccessoryType

    public var subtitleLines: Int = 0
    public var selectionStyle: UITableViewCellSelectionStyle

    public init() {
        self.init(accessory: .disclosureIndicator, selection: true)
    }

    public init(accessory: UITableViewCellAccessoryType, selection: Bool) {
        self.accessory = accessory
        selectionStyle = selection ? .default : .none
    }
}

public class Value2TableViewCell: UITableViewCell {
    public static let identifier: String = "Value2TableViewCell"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: Value2TableViewCell.identifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func fulfill(_ model: Any) {
        guard let model = model as? Value2TableViewCellModel else {
            return
        }
        textLabel?.attributedText = model.title
        detailTextLabel?.attributedText = model.subtitle
        detailTextLabel?.numberOfLines = model.subtitleLines
        imageView?.image = model.image ?? model.imageName.flatMap(UIImage.init(named:))
        accessoryType = model.accessory
        selectionStyle = model.selectionStyle
    }
}

public struct Value2TableViewCellModel: HeightViewModel {
    public var identifier: String = Value2TableViewCell.identifier
    public var height: CGFloat = 44

    public var title: NSAttributedString? = nil
    public var subtitle: NSAttributedString? = nil
    public var imageName: String? = nil
    public var image: UIImage? = nil
    public var accessory: UITableViewCellAccessoryType

    public var subtitleLines: Int = 0
    public var selectionStyle: UITableViewCellSelectionStyle

    public init() {
        self.init(accessory: .disclosureIndicator, selection: true)
    }

    public init(accessory: UITableViewCellAccessoryType, selection: Bool) {
        self.accessory = accessory
        selectionStyle = selection ? .default : .none
    }
}
