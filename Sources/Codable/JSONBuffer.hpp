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

#ifndef __START_POINT_JSON_BUFFER_HPP
#define __START_POINT_JSON_BUFFER_HPP

#include <cstdint>
#include <cstddef>
#include <cassert>
#include <ostream>
#include <vector>
#include "Config.h"
#include "AnyList.hpp"
#include "JSONBuffer.h"

struct Index {
    JSONType type;
    size_t start;
    size_t end;
};

struct JSONArray {
    size_t index;
    size_t count;
};

struct JSONObject {
    size_t index;
    size_t count;
};

class JSONBuffer {
public:
    typedef StartPoint::AnyList<> any_list;

    struct Array {
        size_t count;
    };

    inline explicit JSONBuffer(): _index(), _content(0) {
        appendNull();
    }

    inline JSONBuffer(size_t count, size_t size): _index(), _content(size) {
        _index.reserve(count);
    }

    inline JSONBuffer& operator=(JSONBuffer&& rhs) {
        if (&rhs != this) {
            _index = std::move(rhs._index);
            _content = std::move(rhs._content);
        }
        return *this;
    }

    inline void appendNull() {
        appendType(JSONTypeNull);
    }

    inline void append(int32_t value) {
        auto temp = static_cast<int64_t>(value);
        appendNumber<int64_t>(temp, JSONTypeInt);
    }

    inline void append(uint32_t value) {
        auto temp = static_cast<uint64_t>(value);
        appendNumber<uint64_t>(temp, JSONTypeUint);
    }

    inline void append(int64_t value) {
        appendNumber<int64_t>(value, JSONTypeInt64);
    }

    inline void append(uint64_t value) {
        appendNumber<uint64_t>(value, JSONTypeUint64);
    }

    inline void append(double value) {
        appendNumber<double>(value, JSONTypeDouble);
    }

    inline void append(bool value) {
        appendType(value ? JSONTypeTrue : JSONTypeFalse);
    }

    inline void appendString(unsigned char &value) {
        _content.append(value);
    }

    inline void appendString(const char *value, size_t count) {
        _content.append(value, count);
    }

    inline size_t startString() {
        size_t offset = _index.size();
        size_t start = _content.size();
        _index.push_back(Index{JSONTypeString, start, 0});
        return offset;
    }

    inline void endString(size_t atIndex) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeString);
        index.end = _content.size();
    }

    inline size_t startArray() {
        size_t offset = _index.size();
        size_t start = _content.size();
        _index.push_back(Index{JSONTypeArray, start, 0});
        _content.append<Array>(Array{0});
        return offset;
    }

    inline void endArray(size_t atIndex, size_t count) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeArray);
        index.end = _content.size();
        auto& temp = _content.at<Array>(index.start);
        temp.count = count;
    }

    inline size_t startObject() {
        size_t offset = _index.size();
        size_t start = _content.size();
        _index.push_back(Index{JSONTypeObject, start, 0});
        _content.append<Array>(Array{0});
        return offset;
    }

    inline void endObject(size_t atIndex, size_t count) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeObject);
        index.end = _content.size();
        auto& temp = _content.at<Array>(index.start);
        temp.count = count;
    }

    inline bool empty() const {
        return _index.empty();
    }

    inline size_t count() const {
        return _index.size();
    }

    inline Index& index(size_t atIndex) {
        return _index.at(atIndex);
    }

    template<typename T>
    inline T& number(size_t atIndex) {
        auto index = _index.at(atIndex);
        return _content.at<T>(index.start);
    }

    inline Number& number(size_t atIndex) {
        const auto& index = _index.at(atIndex);
        return _content.at<Number>(index.start);
    }

    inline const char* copyString(size_t atIndex) {
        const auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeString);
        auto size = index.end - index.start;
        assert(size % sizeof(char) == 0);
        auto value = static_cast<char *>(std::malloc(size + 1));
        const auto start = &_content.at<char>(index.start);
        strncpy(value, start, size);
        auto last = value + size;
        *last = '\0';
        return value;
    }

    inline char* string(size_t atIndex, size_t *count) {
        auto index = _index.at(atIndex);
        auto size = index.end - index.start;
        assert(size % sizeof(char) == 0);
        if (count != nullptr) {
            *count = size;
        }
        return &_content.at<char>(index.start);
    }

    inline Array& array(size_t atIndex) {
        auto& index = _index.at(atIndex);
        return _content.at<Array>(index.start);
    }

    inline void array(size_t atIndex, JSONArray *array) {
        assert(array != nullptr);
        auto& index = _index.at(atIndex);
        auto& temp = _content.at<Array>(index.start);
        array->index = atIndex;
        array->count = temp.count;
    }

    inline void object(size_t atIndex, JSONObject *object) {
        assert(object != nullptr);
        auto& index = _index.at(atIndex);
        auto& temp = _content.at<Array>(index.start);
        object->index = atIndex;
        object->count = temp.count;
    }

    inline void printContent(std::ostream &stream) {
        for (size_t i = 0; i < _index.size(); ++i) {
            auto& temp = _index.at(i);
            switch (temp.type) {
                case JSONTypeNull:
                    stream << "null,";
                    break;
                case JSONTypeTrue:
                    stream << "true,";
                    break;
                case JSONTypeFalse:
                    stream << "false,";
                    break;
                case JSONTypeInt: {
                    auto value = number<int32_t>(i);
                    stream << value << ",";
                }
                    break;
                case JSONTypeInt64: {
                    auto value = number<int64_t>(i);
                    stream << value << ",";
                }
                    break;
                case JSONTypeUint: {
                    auto value = number<uint32_t>(i);
                    stream << value << ",";
                }
                    break;
                case JSONTypeUint64: {
                    auto value = number<uint64_t>(i);
                    stream << value << ",";
                }
                    break;
                case JSONTypeDouble: {
                    auto value = number<double>(i);
                    stream << value << ",";
                }
                    break;
                case JSONTypeString: {
                    size_t size = 0;
                    const auto value = string(i, &size);
                    if (size == 0) {
                        stream << "<EMPTY STRING>,";
                    } else {
                        std::string temp(value, size);
                        stream << temp << ",";
                    }
                }
                    break;
                case JSONTypeArray:
                    stream << "\nArray\n";
                    break;
                case JSONTypeObject:
                    stream << "\nObject\n";
                    break;
            }
        }
    }

    inline JSONBuffer* copy(size_t start, size_t count) {
        const auto& is = _index.at(start);
        const auto& ie = _index.at(start + count - 1);
        const auto& cs = _content.at<char>(is.start);
        const auto& ce = _content.at<char>(ie.end);
        assert(_content.size() >= static_cast<size_t>(&ce - &cs));
        assert(_content.first<char>() <= &cs);
        assert(_content.last<char>() + 1>= &ce);

        auto&& index = JSONBuffer::copy(_index, start, count);
        auto&& content = any_list(&cs, &ce);
        return new JSONBuffer(std::move(index), std::move(content));
    }

private:
    inline static std::vector<Index> copy(std::vector<Index>& origin, size_t start, size_t count) {
        auto begin = origin.begin() + start;
        auto end = begin + count;
        auto other = std::vector<Index>(begin, end);
        size_t offset = 0;
        for (size_t i = 0; i < count; ++i) {
            auto& current = other.at(i);
            const auto& other = origin.at(start + i);
            if (i < 1) {
                offset = other.start;
            }
            current.type = other.type;
            current.start = other.start - offset;
            current.end = other.end - offset;
        }
        return other;
    }

    inline JSONBuffer(std::vector<Index>&& index, any_list&& content) : _index(std::move(index)),
        _content(std::move(content)) {}

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline void appendNumber(T& value, JSONType type) {
        assert(type != JSONTypeObject && type != JSONTypeArray && type != JSONTypeNull);
        assert(sizeof(T) == sizeof(Number));
        size_t start = _content.size();
        _content.append<T>(value);
        _index.push_back(Index{type, start, start + sizeof(Number)});
    }

    inline void appendType(JSONType type) {
        size_t start = _content.size();
        _index.push_back(Index{type, start, start});
    }

    std::vector<Index> _index;
    any_list _content;
};

#endif // __START_POINT_JSON_BUFFER_HPP
