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

import Darwin.C

// http://en.cppreference.com/w/cpp/filesystem/file_status
// https://en.cppreference.com/w/cpp/filesystem/status
// https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LowLevelFileMgmt/Introduction.html
public struct FileStatus {
    public let type: FileType
    public let permission: FilePermission

    public init(type: FileType, permission: FilePermission) {
        self.type = type
        self.permission = permission
    }

    // #define  S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)	/* block special */
    // #define  S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)	/* char special */
    // #define  S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)	/* directory */
    // #define  S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)	/* fifo or socket */
    // #define  S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)	/* regular file */
    // #define  S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)	/* symbolic link */
    // #define  S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)	/* socket */
    init(_ status: stat) {
        var perm = FilePermission(status.st_mode & FilePermission.mask.rawValue)
        switch status.st_mode & S_IFMT {
        case S_IFDIR:
            type = FileType.directory
        case S_IFREG:
            type = FileType.regular
        case S_IFLNK:
            type = FileType.symbolicLink
        case S_IFBLK:
            type = FileType.block
        case S_IFCHR:
            type = FileType.character
        case S_IFIFO:
            type = FileType.fifo
        case S_IFSOCK:
            type = FileType.socket
        default:
            type = FileType.unknown
            perm = FilePermission.unknown
        }
        permission = perm
    }

    @inline(__always)
    static var notFound: FileStatus {
        FileStatus(type: .notFound, permission: .none)
    }
}
