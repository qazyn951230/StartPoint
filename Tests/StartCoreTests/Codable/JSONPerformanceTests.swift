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

@testable import StartCore
import XCTest

class JSONPerformanceTests: XCTestCase {
    static var xpmBuildSettings = Data()
    static var sample = Data()

    override class func setUp() {
        let bundle = Bundle(identifier: "com.undev.StartPointTests")!
        let path1 = bundle.url(forResource: "xpm_build_settings", withExtension: "json")!
        xpmBuildSettings = try! Data(contentsOf: path1)
        let path2 = bundle.url(forResource: "sample", withExtension: "json")!
        sample = try! Data(contentsOf: path2)
    }

    func testParsingPerformance() {
        measure {
            _ = try! JSON.parse(data: JSONPerformanceTests.xpmBuildSettings)
        }
    }

    func testNSParsingPerformance() {
        measure {
            _ = try! JSONSerialization.jsonObject(with: JSONPerformanceTests.xpmBuildSettings)
        }
    }

    func testParsingSamplePerformance() {
        measure {
            _ = try! JSON.parse(data: JSONPerformanceTests.sample)
        }
    }

    func testNSParsingSamplePerformance() {
        measure {
            _ = try! JSONSerialization.jsonObject(with: JSONPerformanceTests.sample)
        }
    }

    func testDecodePerformance() {
        let decoder = StartJSONDecoder()
        measure {
            _ = try! decoder.decode(BuildSettings.self, from: JSONPerformanceTests.xpmBuildSettings)
        }
    }

    func testNSDecodePerformance() {
        let decoder = JSONDecoder()
        measure {
            _ = try! decoder.decode(BuildSettings.self, from: JSONPerformanceTests.xpmBuildSettings)
        }
    }
}

fileprivate final class BuildSettings: Codable {
    let action: XCAction
    let buildSettings: XCBuildSettings
    let target: String
}

fileprivate enum XCAction: String, Codable, Hashable {
    case build
    case buildForTesting = "build-for-testing"
    case analyze
    case archive
    case test
    case testWithoutBuilding = "test-without-building"
    case installSources = "install-src"
    case install
    case clean
}

fileprivate enum MachOType: String, Codable {
    // Executable binary. Application, command-line tool, and kernel extension target types.
    case executable = "mh_execute"
    // Bundle binary. Bundle and plug-in target types.
    case bundle = "mh_bundle"
    // Relocatable object file.
    case object = "mh_object"
    // Dynamic library binary. Dynamic library and framework target types.
    case dynamicLibrary = "mh_dylib"
    // Static library binary. Static library target types.
    case staticLibrary = "staticlib"
}

fileprivate enum XCPlatform: String, Codable {
    case macOS = "macosx"
    case iOS = "iphoneos"
    case iOSSimulator = "iphonesimulator"
    case watchOS = "watchos"
    case watchOSSimulator = "watchsimulator"
    case tvOS = "appletvos"
    case tvOSSimulator = "appletvsimulator"

    public var isDevice: Bool {
        !isSimulator
    }

    public var isSimulator: Bool {
        self == XCPlatform.iOSSimulator ||
            self == XCPlatform.watchOSSimulator ||
            self == XCPlatform.tvOSSimulator
    }
}

fileprivate enum ProductType: String, Codable {
    case appExtension = "com.apple.product-type.app-extension"
    case application = "com.apple.product-type.application"
    case bundle = "com.apple.product-type.bundle"
    case framework = "com.apple.product-type.framework"
    case frameworkStatic = "com.apple.product-type.framework.static"
    case inAppPurchaseContent = "com.apple.product-type.in-app-purchase-content"
    case kernelExtension = "com.apple.product-type.kernel-extension"
    case libraryDynamic = "com.apple.product-type.library.dynamic"
    case libraryStatic = "com.apple.product-type.library.static"
    case tool = "com.apple.product-type.tool"
    case tvAppExtension = "com.apple.product-type.tv-app-extension"
    case uiTest = "com.apple.product-type.bundle.ui-testing"
    case unitTest = "com.apple.product-type.bundle.unit-test"
    case watchApp = "com.apple.product-type.application.watchapp"
    case watchApp2 = "com.apple.product-type.application.watchapp2"
    case watchExtension = "com.apple.product-type.watchkit-extension"
    case watchExtension2 = "com.apple.product-type.watchkit2-extension"
}


fileprivate final class XCBuildSettings: Codable {
    // build
    public let action: XCAction // ACTION

    // .../Build/Products
    public let builtDirectory: Path // BUILD_DIR
    // .../Build/Products/Release-iphoneos
    public let builtProductsDirectory: Path // BUILT_PRODUCTS_DIR

    // Debug, Release
    public let configuration: String // CONFIGURATION
    // StartPoint.framework
    public let contentsFolder: String? // CONTENTS_FOLDER_PATH

    // YES
    public let enableBitcode: Bool // ENABLE_BITCODE
    // -iphoneos
    public let effectivePlatformName: String? // EFFECTIVE_PLATFORM_NAME
    // StartPoint.framework
    public let executableFolder: String? // EXECUTABLE_FOLDER_PATH
    // StartPoint
    public let executableName: String // EXECUTABLE_NAME
    // StartPoint.framework/StartPoint
    public let executablePath: String // EXECUTABLE_PATH

    // StartPoint.framework/Frameworks
    public let frameworksFolder: String? // FRAMEWORKS_FOLDER_PATH

    // StartPoint.framework
    public let fullProductName: String // FULL_PRODUCT_NAME

    // mh_dylib
    public let machOType: MachOType // MACH_O_TYPE

    // /Users/USERNAME/Library/Developer/Xcode/DerivedData/PROJECT/Build/Intermediates.noindex
    public let objectRoot: Path // OBJROOT

    // iphoneos
    public let platform: XCPlatform // PLATFORM_NAME

    // com.undev.iOS.StartPoint
    public let productBundleIdentifier: String? // PRODUCT_BUNDLE_IDENTIFIER
    // StartPoint
    public let productModuleName: String? // PRODUCT_MODULE_NAME
    // StartPoint
    public let productName: String // PRODUCT_NAME
    // com.apple.product-type.framework
    public let productType: ProductType // PRODUCT_TYPE

    // StartPoint
    public let project: String // PROJECT
    // /PATH/TO/PROJECT
    public let projectDirectory: Path // PROJECT_DIR
    // /PATH/TO/PROJECT/PROJECT.xcodeproj
    public let projectFile: Path // PROJECT_FILE_PATH
    // StartPoint
    public let projectName: String // PROJECT_NAME

    // "iphonesimulator iphoneos"
    public let supportedPlatforms: [XCPlatform] // SUPPORTED_PLATFORMS

    // iphonesimulator iphoneos
    public let targetBuildDirectory: Path // TARGET_BUILD_DIR
    // StartPoint_iOS
    public let targetName: String // TARGET_NAME

    // framework
    public let wrapperExtension: String? // WRAPPER_EXTENSION
    // StartPoint.framework
    public let wrapperName: String? // WRAPPER_NAME
    // .framework
    public let wrapperSuffix: String? // WRAPPER_SUFFIX

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(XCAction.self, forKey: .action)
        builtDirectory = try container.decode(Path.self, forKey: .builtDirectory)
        builtProductsDirectory = try container.decode(Path.self, forKey: .builtProductsDirectory)
        configuration = try container.decode(String.self, forKey: .configuration)
        contentsFolder = try container.decodeIfPresent(String.self, forKey: .contentsFolder)
        enableBitcode = try container.decode(plist: Bool.self, forKey: .enableBitcode)
        effectivePlatformName = try container.decodeIfPresent(String.self, forKey: .effectivePlatformName)
        executableFolder = try container.decodeIfPresent(String.self, forKey: .executableFolder)
        executableName = try container.decode(String.self, forKey: .executableName)
        executablePath = try container.decode(String.self, forKey: .executablePath)
        frameworksFolder = try container.decodeIfPresent(String.self, forKey: .frameworksFolder)
        fullProductName = try container.decode(String.self, forKey: .fullProductName)
        machOType = try container.decode(MachOType.self, forKey: .machOType)
        objectRoot = try container.decode(Path.self, forKey: .objectRoot)
        platform = try container.decode(XCPlatform.self, forKey: .platform)
        productBundleIdentifier = try container.decodeIfPresent(String.self, forKey: .productBundleIdentifier)
        productModuleName = try container.decodeIfPresent(String.self, forKey: .productModuleName)
        productName = try container.decode(String.self, forKey: .productName)
        productType = try container.decode(ProductType.self, forKey: .productType)
        project = try container.decode(String.self, forKey: .project)
        projectDirectory = try container.decode(Path.self, forKey: .projectDirectory)
        projectFile = try container.decode(Path.self, forKey: .projectFile)
        projectName = try container.decode(String.self, forKey: .projectName)
        supportedPlatforms = try container.decode(split: XCPlatform.self, forKey: .supportedPlatforms)
        targetBuildDirectory = try container.decode(Path.self, forKey: .targetBuildDirectory)
        targetName = try container.decode(String.self, forKey: .targetName)
        wrapperExtension = try container.decodeIfPresent(String.self, forKey: .wrapperExtension)
        wrapperName = try container.decodeIfPresent(String.self, forKey: .wrapperName)
        wrapperSuffix = try container.decodeIfPresent(String.self, forKey: .wrapperSuffix)
    }

    public func support(platform: XCPlatform) -> Bool {
        supportedPlatforms.contains(platform)
    }

    public func support(platforms: [XCPlatform]) -> Bool {
        supportedPlatforms.allSatisfy { platforms.contains($0) }
    }

    // ┌─┬ ARCHIVE
    // │ ├ Symbol Link
    // │ │ <OBJROOT>/ArchiveIntermediates/<TARGET_NAME OR Scheme>/BuildProductsPath/
    // │ │      <CONFIGURATION><EFFECTIVE_PLATFORM_NAME>
    // │ └ File
    // │   <OBJROOT>/ArchiveIntermediates/<TARGET_NAME OR Scheme>/IntermediateBuildFilesPath/
    // │        UninstalledProducts/<Platform>
    // └── BUILD
    //     <BUILT_PRODUCTS_DIR>
    public func productDirectory() -> Path {
        if action == XCAction.archive {
            // this is a symbol link
            return objectRoot.join("ArchiveIntermediates", targetName, "BuildProductsPath",
                configuration + (effectivePlatformName ?? ""))
        } else {
            return builtProductsDirectory
        }
    }

    public func product() -> Path {
        return productDirectory().join(fullProductName)
    }

    public func module(base: Path? =  nil) -> Path? {
        guard let name = productModuleName, let folder = contentsFolder else {
            return nil
        }
        let temp = base ?? productDirectory()
        return temp.join(folder, "Modules", name + ".swiftmodule")
    }

    // productDirectory/
    public func executable(base: Path? = nil) -> Path {
        let base = base ?? productDirectory()
        return base.join(executablePath)
    }

    enum CodingKeys: String, CodingKey {
        case action = "ACTION"
        case builtDirectory = "BUILD_DIR"
        case builtProductsDirectory = "BUILT_PRODUCTS_DIR"
        case configuration = "CONFIGURATION"
        case contentsFolder = "CONTENTS_FOLDER_PATH"
        case enableBitcode = "ENABLE_BITCODE"
        case effectivePlatformName = "EFFECTIVE_PLATFORM_NAME"
        case executableFolder = "EXECUTABLE_FOLDER_PATH"
        case executableName = "EXECUTABLE_NAME"
        case executablePath = "EXECUTABLE_PATH"
        case frameworksFolder = "FRAMEWORKS_FOLDER_PATH"
        case fullProductName = "FULL_PRODUCT_NAME"
        case machOType = "MACH_O_TYPE"
        case objectRoot = "OBJROOT"
        case platform = "PLATFORM_NAME"
        case productBundleIdentifier = "PRODUCT_BUNDLE_IDENTIFIER"
        case productModuleName = "PRODUCT_MODULE_NAME"
        case productName = "PRODUCT_NAME"
        case productType = "PRODUCT_TYPE"
        case project = "PROJECT"
        case projectDirectory = "PROJECT_DIR"
        case projectFile = "PROJECT_FILE_PATH"
        case projectName = "PROJECT_NAME"
        case supportedPlatforms = "SUPPORTED_PLATFORMS"
        case targetBuildDirectory = "TARGET_BUILD_DIR"
        case targetName = "TARGET_NAME"
        case wrapperExtension = "WRAPPER_EXTENSION"
        case wrapperName = "WRAPPER_NAME"
        case wrapperSuffix = "WRAPPER_SUFFIX"
    }
}
