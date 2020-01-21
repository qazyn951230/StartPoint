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

protocol ElementVisitor {
    func visit(basic element: BasicElement)
    func visit<View: UIView>(view element: Element<View>)
    func visit<Layer: CALayer>(layer element: BasicLayerElement<Layer>)
}

final class ElementHtmlPrinter: DataStreamWriter, ElementVisitor {
    let flexPrinter: FlexHtmlPrinter

    override init(stream: DataStream) {
        flexPrinter = FlexHtmlPrinter(stream: stream, options: [])
        super.init(stream: stream)
    }

    func print(basic element: BasicElement) {
//        flexPrinter.header()
        process(basic: element)
//        flexPrinter.footer()
    }

    func process(basic element: BasicElement) {
        intent()
        write("<div ")
        element.accept(visitor: self)
        write(">\n")
        if element.children.isNotEmpty {
            level += 1
            for child in element.children {
                process(basic: child)
            }
            level -= 1
        }
        intent()
        write("</div>\n")
    }

    func visit(basic element: BasicElement) {
        flexPrinter.visit(box: element.layout.box)
        write("style=\"")
        flexPrinter.process(style: element.layout.style)
        let hex: UInt32 = UInt32.random(in: 0...0xffffff)
        write("background-color:#")
        write(String(hex, radix: 16, uppercase: true))
        flexPrinter.endProperty()
        write("\" ")
    }

    func visit<View: UIView>(view element: Element<View>) {
        write("layout=\"")
        write("width: \(element._frame.width); ")
        write("height: \(element._frame.height); ")
        write("top: \(element._frame.y); ")
        write("left: \(element._frame.x); ")
        write("\" ")
//        flexPrinter.visit(box: element.layout.box)
//        write("style=\"")
//        flexPrinter.process(style: element.layout.style)
//        var hex: UInt32 = 0
//        if Runner.isMain(), let view = element.view {
//            hex = view.backgroundColor?.rgbaHex() ?? 0
//        } else if let background = element.pendingState.backgroundColor {
//            hex = background?.rgbaHex() ?? 0
//        } else {
//            hex = UInt32.random(in: 0...0xffffff)
//        }
//        write("background-color:#")
//        hex = hex & 0xffffff
//        write(String(hex, radix: 16, uppercase: true))
//        flexPrinter.endProperty()
//        write("\" ")
    }

    func visit<Layer: CALayer>(layer element: BasicLayerElement<Layer>) {
        flexPrinter.visit(box: element.layout.box)
        write("style=\"")
        flexPrinter.process(style: element.layout.style)
        var hex: UInt32 = 0
        if Runner.isMain(), let layer = element.layer {
            hex = layer.backgroundColor.map(UIColor.init(cgColor:))?.rgbaHex() ?? 0
        } else if let background = element.pendingState.backgroundColor {
            hex = background?.rgbaHex() ?? 0
        } else {
            hex = UInt32.random(in: 0...0xffffff)
        }
        hex = hex & 0xffffff
        write("background-color:#")
        write(String(hex, radix: 16, uppercase: true))
        flexPrinter.endProperty()
        write("\" ")
    }
}

public extension BasicElement {
    func print() {
        let printer = ElementHtmlPrinter()
        printer.print(basic: self)
    }
}
#endif // #if os(iOS)
