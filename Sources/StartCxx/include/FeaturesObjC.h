// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
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

#ifndef START_POINT_FEATURES_OBJC_H
#define START_POINT_FEATURES_OBJC_H

#define SP_OBJC_HAS_ARC COMPILER_HAS_FEATURE(objc_arc)

// @see: https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFDesignConcepts/Articles/tollFreeBridgedTypes.html
// @code{__bridge}:
// transfers a pointer between Objective-C and Core Foundation with no transfer of ownership.
// @code{__bridge_retained} or @code{CFBridgingRetain}:
// casts an Objective-C pointer to a Core Foundation pointer and also transfers ownership to you.
// You are responsible for calling CFRelease or a related function to relinquish ownership of the object.
// @code{__bridge_transfer} or @code{CFBridgingRelease}:
// moves a non-Objective-C pointer to Objective-C and also transfers ownership to ARC.
// ARC is responsible for relinquishing ownership of the object.

//#if SP_OBJC_HAS_ARC
//#   define SP_BRIDGE(Type, VALUE) ((__bridge Type)(VALUE))
//#   define SP_BRIDGE_TRANSFER(CFType, VALUE) ((__bridge_transfer CFType)(VALUE))
//#   define SP_BRIDGE_RETAINED(NSType, VALUE) ((__bridge_retained NSType)(VALUE))
//#elif SP_LANG_CXX
//#   define SP_BRIDGE(Type, VALUE) (reinterpret_cast<Type>(VALUE))
//#   define SP_BRIDGE_TRANSFER(NSType, VALUE) (reinterpret_cast<NSType>(VALUE))
//#   define SP_BRIDGE_RETAINED(CFType, VALUE) (reinterpret_cast<CFType>(VALUE))
//#else
//#   define SP_BRIDGE(Type, VALUE) ((Type)(VALUE))
//#   define SP_BRIDGE_TRANSFER(CFType, VALUE) ((CFType)(VALUE))
//#   define SP_BRIDGE_RETAINED(NSType, VALUE) ((NSType)(VALUE))
//#endif

#endif // START_POINT_FEATURES_OBJC_H
