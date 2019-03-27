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

final class FlexHtmlPrinter: DataStreamWriter {
    let layout: Bool
    let style: Bool
    let fullHtml: Bool
    let randomBackground: Bool

    init(stream: DataStream, options: FlexPrintOptions) {
        layout = options.contains(.layout)
        style = options.contains(.style)
        fullHtml = options.contains(.fullHtml)
        randomBackground = options.contains(.randomBackground)
        super.init(stream: stream)
    }

    func header() {
        let text = """
<!DOCTYPE html>
<html style="display: flex; height: 100%;">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<style type="text/css">
  body {
    margin: 0;
    display: flex;
    width: 100%;
    height: 100%;
  }
</style>
<head>
</head>
<body>
"""
        write(text)
        newline()
    }

    func footer() {
        write("</body>\n</html>\n")
    }

    func print(layout: FlexLayout) {
        if fullHtml {
            header()
            visit(layout: layout)
            footer()
        } else {
            visit(layout: layout)
        }
    }

    func process(layout: FlexLayout) {
        if self.layout {
            visit(box: layout.box)
        }
        if style {
            visit(style: layout.style)
        }
    }

    func visit(layout: FlexLayout) {
        intent()
        write("<div ")
        process(layout: layout)
        write(">\n")
        if layout.children.isNotEmpty {
            level += 1
            for child in layout.children {
                visit(layout: child)
            }
            level -= 1
        }
        intent()
        write("</div>\n")
    }

    func startProperty(name: String) {
        write(name)
        colon()
        space()
    }

    func endProperty() {
        semicolon()
        space()
    }

    func process(style: FlexStyle) {
        //        if style.direction != Direction.inherit {
//            write("")
//        }
        // Web default value is row
        if style.flexDirection != FlexDirection.row {
            startProperty(name: "flex-direction")
            switch style.flexDirection {
            case .column:
                write("column")
            case .row:
                write("row")
            case .columnReverse:
                write("column-reverse")
            case .rowReverse:
                write("row-reverse")
            }
            endProperty()
        }
        if style.justifyContent != JustifyContent.flexStart {
            startProperty(name: "justify-content")
            switch style.justifyContent {
            case .flexStart:
                write("flex-start")
            case .flexEnd:
                write("flex-end")
            case .center:
                write("center")
            case .spaceBetween:
                write("space-between")
            case .spaceAround:
                write("space-around")
            case .spaceEvenly:
                break
            }
            endProperty()
        }
        // Web default value is stretch
        if style.alignContent != AlignContent.stretch {
            startProperty(name: "align-content")
            switch style.alignContent {
            case .flexStart:
                write("flex-start")
            case .flexEnd:
                write("flex-end")
            case .center:
                write("center")
            case .spaceBetween:
                write("space-between")
            case .spaceAround:
                write("space-around")
            case .stretch:
                write("stretch")
            }
            endProperty()
        }
        if style.alignItems != AlignItems.stretch {
            startProperty(name: "align-items")
            switch style.alignItems {
            case .flexStart:
                write("flex-start")
            case .flexEnd:
                write("flex-end")
            case .center:
                write("center")
            case .baseline:
                write("baseline")
            case .stretch:
                write("stretch")
            }
            endProperty()
        }
        if style.flexWrap != FlexWrap.nowrap {
            startProperty(name: "flex-wrap")
            switch style.flexWrap {
            case .nowrap:
                write("nowrap")
            case .wrap:
                write("wrap")
            case .wrapReverse:
                write("wrap-reverse")
            }
            endProperty()
        }
        if style.overflow != Overflow.visible {
            startProperty(name: "overflow")
            switch style.overflow {
            case .visible:
                write("visible")
            case .hidden:
                write("hidden")
            case .scroll:
                write("scroll")
            }
            endProperty()
        }
        if style.display != Display.none {
            startProperty(name: "display")
            switch style.display {
            case .flex:
                write("flex")
            case .none:
                write("none")
            }
            endProperty()
        }
        // Web default value is 0
        if style.flexGrow != 0 {
            write("flex-grow:\(style.flexGrow)")
            endProperty()
        }
        // Web default value is 1
        if style.flexShrink != 1 {
            write("flex-shrink:\(style.flexShrink)")
            endProperty()
        }
        // Web default value is auto
        if style.flexBasis != FlexBasis.auto {
            write("flex-basis:\(style.flexBasis.resolve(by: 1))")
            endProperty()
        }
//        if style.positionType != PositionType.relative  {
        startProperty(name: "position")
        switch style.positionType {
        case .relative:
            write("relative")
        case .absolute:
            write("absolute")
        }
        endProperty()
//        }
        if style.margin != StyleInsets.zero {
            startProperty(name: "margin") // 上 右 下 左
            write(style.margin.top.description)
            space()
            write(style.margin.trailing(direction: .row).description)
            space()
            write(style.margin.bottom.description)
            space()
            write(style.margin.leading(direction: .row).description)
            endProperty()
        }
        if style.padding != StyleInsets.zero {
            startProperty(name: "padding") // 上 右 下 左
            write(style.padding.top.description)
            space()
            write(style.padding.trailing(direction: .row).description)
            space()
            write(style.padding.bottom.description)
            space()
            write(style.padding.leading(direction: .row).description)
            endProperty()
        }
        if style.border != StyleInsets.zero {
            startProperty(name: "border") // 上 右 下 左
            write(style.border.top.description)
            space()
            write(style.border.trailing(direction: .row).description)
            space()
            write(style.border.bottom.description)
            space()
            write(style.border.leading(direction: .row).description)
            endProperty()
        }
        if style.width != StyleValue.auto {
            startProperty(name: "width")
            write(style.width.description)
            endProperty()
        }
        if style.height != StyleValue.auto {
            startProperty(name: "height")
            write(style.height.description)
            endProperty()
        }
        // https://drafts.csswg.org/css2/visudet.html#propdef-min-width
        if style.minWidth != StyleValue.length(0.0) {
            startProperty(name: "min-width")
            write(style.minWidth.description)
            endProperty()
        }
        if style.minHeight != StyleValue.length(0.0) {
            startProperty(name: "min-height")
            write(style.minHeight.description)
            endProperty()
        }
        // https://drafts.csswg.org/css2/visudet.html#propdef-max-width
        if let maxWidth = style.maxWidth {
            startProperty(name: "max-width")
            write(maxWidth.description)
            endProperty()
        }
        if let maxHeight = style.maxHeight {
            startProperty(name: "max-height")
            write(maxHeight.description)
            endProperty()
        }
        if randomBackground {
            let hex = UInt32.random(in: 0...0xffffff)
            write("background-color:#")
            write(String(hex, radix: 16, uppercase: true))
            endProperty()
        }
    }

    func visit(style: FlexStyle) {
        write("style=\"")
        process(style: style)
        write("\" ")
    }

    func visit(box: FlexBox) {
        write("layout=\"")
        write("width: \(box.width); ")
        write("height: \(box.height); ")
        write("top: \(box.top); ")
        write("left: \(box.left); ")
        write("\" ")
    }
}

public struct FlexPrintOptions: OptionSet {
    public typealias RawValue = Int

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let layout = FlexPrintOptions(rawValue: 1)
    public static let style = FlexPrintOptions(rawValue: 1 << 1)
    public static let fullHtml = FlexPrintOptions(rawValue: 1 << 2)
    public static let randomBackground = FlexPrintOptions(rawValue: 1 << 3)
}

public extension FlexLayout {
    func print(options: FlexPrintOptions? = nil) {
        let _options = options ?? [FlexPrintOptions.layout, .style, .fullHtml, .randomBackground]
        let printer = FlexHtmlPrinter(stream: DataStream.standardOutput(), options: _options)
        printer.print(layout: self)
    }
}
