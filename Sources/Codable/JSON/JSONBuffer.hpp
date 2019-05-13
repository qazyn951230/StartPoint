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

struct JSONArray {
    size_t index;
    size_t count;
    size_t* item;
};

struct JSONObject {
    size_t index;
    size_t count;
    size_t* item;
};

class JSONBuffer {
public:
    typedef StartPoint::AnyList<> any_list;
    typedef std::vector<JSONIndex>::iterator index_iterator;

    struct Array {
        size_t count;
    };

    inline explicit JSONBuffer() : _offset(0), _index(), _content(0) {}

    inline JSONBuffer(size_t count, size_t size) : _offset(0), _index(), _content(size) {
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
        Number number{.int64 = 0};
        number.i.int32 = value;
        appendNumber(number, JSONTypeInt);
    }

    inline void append(uint32_t value) {
        Number number{.int64 = 0};
        number.u.uint32 = value;
        appendNumber(number, JSONTypeUint);
    }

    inline void append(int64_t value) {
        Number number{.int64 = value};
        appendNumber(number, JSONTypeInt64);
    }

    inline void append(uint64_t value) {
        Number number{.uint64 = value};
        appendNumber(number, JSONTypeUint64);
    }

    inline void append(double value) {
        Number number{.floating = value};
        appendNumber(number, JSONTypeDouble);
    }

    inline void append(bool value) {
        appendType(value ? JSONTypeTrue : JSONTypeFalse);
    }

    inline void append(const char* value, size_t count) {
        auto start = _content.size();
        _content.append(value, count);
        auto end = _content.size();
        auto size = static_cast<int64_t>(end - start);
        _index.push_back(JSONIndex{JSONTypeString, start, end, Number{.int64 = size}});
    }

    inline void appendString(unsigned char& value) {
        _content.append(value);
    }

    inline void appendString(const char* value, size_t count) {
        _content.append(value, count);
    }

    inline size_t startString() {
        auto offset = _index.size();
        size_t start = _content.size();
        _index.push_back(JSONIndex{JSONTypeString, start, 0, Number{.int64 = 0}});
        return offset;
    }

    inline void endString(const size_t& atIndex) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeString);
        index.end = _content.size();
        index.value.int64 = static_cast<int64_t>(index.end - index.start);
    }

    inline size_t startArray() {
        auto offset = _index.size();
        size_t start = _content.size();
        _index.push_back(JSONIndex{JSONTypeArray, start, 0, Number{.int64 = 0}});
        return offset;
    }

    inline void endArray(const size_t& atIndex, const size_t& count) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeArray);
        index.end = _content.size();
        index.value.int64 = static_cast<int64_t>(count);
    }

    inline size_t startObject() {
        auto offset = _index.size();
        size_t start = _content.size();
        _index.push_back(JSONIndex{JSONTypeObject, start, 0, Number{.int64 = 0}});
        return offset;
    }

    inline void endObject(const size_t& atIndex, const size_t& count) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeObject);
        index.end = _content.size();
        index.value.int64 = static_cast<int64_t>(count);
    }

    inline bool empty() const {
        return _index.empty();
    }

    inline size_t count() const {
        return _index.size();
    }

    inline JSONIndex& index(const size_t& atIndex) {
        return _index.at(atIndex);
    }

    inline JSONIndex* indexAt(const size_t& atIndex) {
        return &_index.at(atIndex);
    }

    inline void number(size_t atIndex, Number& result) {
        const auto& index = _index.at(atIndex);
        result.int64 = index.value.int64;
    }

    inline const char* copyString(size_t atIndex) {
        const auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeString);
        auto size = index.end - index.start;
        assert(size % sizeof(char) == 0);
        auto value = static_cast<char*>(std::malloc(size + 1));
        const auto start = &_content.at<char>(index.start);
        strncpy(value, start, size);
        auto last = value + size;
        *last = '\0';
        return value;
    }

    inline char* string(const size_t& atIndex, size_t* count) {
        auto& index = _index.at(atIndex);
        auto size = index.end - index.start;
        assert(size % sizeof(char) == 0);
        if (count != nullptr) {
            *count = size;
        }
        return &_content.at<char>(index.start);
    }

    inline void array(const size_t& atIndex, JSONArray& array, bool resolve = false) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeArray);
        array.index = atIndex;
        array.count = static_cast<size_t>(index.value.int64);
        if (resolve) {
            resolveArray(array);
        } else {
            array.item = nullptr;
        }
    }

    inline void resolveArray(JSONArray& array) {
        assert(_index.at(array.index).type == JSONTypeArray);
        auto item = new size_t[array.count];
        array.item = item;
        auto current = _index.begin() + array.index;
        size_t index = array.index;
        for (size_t i = 0; i < array.count; ++i, ++item) {
            if (i < 1) {
                index += 1;
                current += 1;
            } else {
                skipArrayValue(current, index);
            }
            *item = index;
        }
    }

    inline void object(const size_t& atIndex, JSONObject& object, bool resolve = false) {
        auto& index = _index.at(atIndex);
        assert(index.type == JSONTypeObject);
        object.index = atIndex;
        object.count = static_cast<size_t>(index.value.int64);
        if (resolve) {
            resolveObject(object);
        } else {
            object.item = nullptr;
        }
    }

    inline void resolveObject(JSONObject& object) {
        assert(_index.at(object.index).type == JSONTypeObject);
        auto item = new size_t[object.count];
        object.item = item;
        auto current = _index.begin() + object.index;
        size_t index = object.index;
        for (size_t i = 0; i < object.count; ++i, ++item) {
            if (i < 1) {
                index += 1;
                current += 1;
            } else {
                skipObjectValue(current, index);
            }
            *item = index;
        }
    }

    inline void printContent(std::ostream& stream) {
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
                    Number num;
                    number(i, num);
                    stream << num.i.int32 << ",";
                }
                    break;
                case JSONTypeInt64: {
                    Number num;
                    number(i, num);
                    stream << num.int64 << ",";
                }
                    break;
                case JSONTypeUint: {
                    Number num;
                    number(i, num);
                    stream << num.u.uint32 << ",";
                }
                    break;
                case JSONTypeUint64: {
                    Number num;
                    number(i, num);
                    stream << num.uint64 << ",";
                }
                    break;
                case JSONTypeDouble: {
                    Number num;
                    number(i, num);
                    stream << num.floating << ",";
                }
                    break;
                case JSONTypeString: {
                    size_t size = 0;
                    const auto value = string(i, &size);
                    if (size == 0) {
                        stream << "<EMPTY STRING>,";
                    } else {
                        std::string str(value, size);
                        stream << str << ",";
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
        return nullptr;
    }

private:
    static constexpr size_t size_of_number = sizeof(int64_t);

    inline JSONBuffer(size_t offset, std::vector<JSONIndex>&& index, any_list&& content) :
        _offset(offset), _index(std::move(index)), _content(std::move(content)) {}

    inline void appendNumber(const Number& value, const JSONType& type) {
        assert(type != JSONTypeObject && type != JSONTypeArray && type != JSONTypeNull);
        size_t start = _content.size();
        _index.push_back(JSONIndex{type, start, start, value});
    }

    inline void appendType(const JSONType& type) {
        size_t start = _content.size();
        _index.push_back(JSONIndex{type, start, start, Number{.int64=0}});
    }

    inline void skipArrayValue(index_iterator& current, size_t& index) {
        if (current->type == JSONTypeArray) {
            auto n = static_cast<size_t>(current->value.int64);
            current += 1;
            index += 1;
            for (size_t i = 0; i < n; ++i) {
                skipArrayValue(current, index);
            }
        } else if (current->type == JSONTypeObject) {
            skipObjectValue(current, index);
        } else {
            index += 1;
            current += 1;
        }
    }

    inline void skipObjectValue(index_iterator& current, size_t& index) {
        assert(current->type == JSONTypeString);
        index += 1;
        current += 1;
        if (current->type == JSONTypeArray) {
            skipArrayValue(current, index);
        } else if (current->type == JSONTypeObject) {
            auto n = static_cast<size_t>(current->value.int64);
            current += 1;
            index += 1;
            for (size_t i = 0; i < n; ++i) {
                skipObjectValue(current, index);
            }
        } else {
            index += 1;
            current += 1;
        }
    }

    size_t _offset;
    std::vector<JSONIndex> _index;
    any_list _content;
};

#endif // __START_POINT_JSON_BUFFER_HPP
