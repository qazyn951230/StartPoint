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

import Foundation

public protocol ScrollViewModel {
    associatedtype Model
    func numberOfSections() -> Int
    func numberOfCellModels(in section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> Model
}

public extension ScrollViewModel {
    public func toIndex(_ indexPath: IndexPath) -> Int {
        if indexPath.section > numberOfSections() {
            return 0
        }
        let i = (0 ..< indexPath.section).reduce(0) { result, next in
            return result + numberOfCellModels(in: next)
        }
        return i + indexPath.row
    }
}

public protocol ArrayScrollViewModel: ScrollViewModel {
    var cellModels: [Model] { get }

    func cellModel(at index: Int) -> Model
}

public extension ArrayScrollViewModel {
    public func cellModel(at indexPath: IndexPath) -> Model {
        return cellModel(at: toIndex(indexPath))
    }

    public func cellModel(at index: Int) -> Model {
        return cellModels[index]
    }

    public func numberOfSections() -> Int {
        return cellModels.count > 0 ? 1 : 0
    }

    public func numberOfCellModels(in section: Int) -> Int {
        return cellModels.count
    }
}
