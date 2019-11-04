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

#ifndef START_POINT_STREAM_HPP
#define START_POINT_STREAM_HPP

#include <cstddef>
#include <memory>
#include "Config.h"

SP_CPP_FILE_BEGIN

class ByteStream {
public:
    using byte_t = std::uint8_t;
    using size_t = std::size_t;

    virtual ~ByteStream() = default;

    [[nodiscard]] virtual bool effective() const = 0;

    [[nodiscard]] virtual const byte_t* current() const = 0;

    virtual byte_t next() {
        move();
        return peek();
    }

    virtual byte_t take() {
        auto value = peek();
        move();
        return value;
    }

    virtual bool take(size_t, byte_t* SP_NONNULL* SP_NULLABLE) = 0;

    virtual byte_t peek() = 0;

    virtual byte_t peek(size_t) = 0;

    virtual bool move() = 0;

    virtual bool move(size_t) = 0;
};

class Uint8Stream final : public ByteStream {
public:
    using byte_t = ByteStream::byte_t;

    Uint8Stream(const byte_t* SP_NULLABLE data, size_t count, bool needsFree) :
        _data(data), _count(data != nullptr ? count : 0), _needsFree(needsFree),
        _index(0), _current(const_cast<byte_t*>(data)), _nullTerminated(count < 1) {}

    [[nodiscard]] bool effective() const override {
        return _nullTerminated ? !_terminated : _index < _count;
    }

    [[nodiscard]] const byte_t* current() const override {
        return _current;
    }

    bool take(size_t size, byte_t* SP_NONNULL* SP_NULLABLE result) override {
        if (_index + size < _count) {
            *result = _current;
            _index += size;
            return true;
        }
        *result = nullptr;
        return false;
    }

    byte_t peek() override {
        if (effective()) {
            return *_current;
        }
        return 0;
    }

    byte_t peek(size_t offset) override {
        if (_nullTerminated) {
            auto t = _current;
            const auto n = _current + offset;
            while (t != n) {
                if (*t == 0) {
                    break;
                }
                t += 1;
            }
            return *t;
        } else {
            if (_index + offset < _count) {
                return *(_current + offset);
            } else {
                return 0;
            }
        }
    }

    bool move() override {
        if (_nullTerminated) {
            if (_terminated) {
                return false;
            }
            _current += 1;
            _terminated = *_current == 0;
            return true;
        } else {
            _current += 1;
            _index += 1;
            return effective();
        }
    }

    bool move(size_t offset) override {
        if (_nullTerminated) {
            if (_terminated) {
                return false;
            }
            auto t = _current;
            const auto n = _current + offset;
            while (t != n) {
                if (*t == 0) {
                    return false;
                }
                t += 1;
            }
            _current = t;
            _terminated = *_current == 0;
            return true;
        } else {
            if (_index + offset < _count) {
                _current += offset;
                _index += offset;
            }
            return effective();
        }
    }

private:
    const byte_t* SP_NULLABLE _data;
    const size_t _count;
    const bool _needsFree;
    const bool _nullTerminated;
    size_t _index;
    byte_t* _current;
    bool _terminated = false;
};

class ByteStreams final {
public:
    using byte_t = ByteStream::byte_t;
    using size_t = ByteStream::size_t;

    using delegate_t = std::unique_ptr<ByteStream>;

    ByteStreams(const byte_t* SP_NULLABLE data, size_t count, bool needsFree = false) {
        _delegate = std::make_unique<Uint8Stream>(data, count, needsFree);
    }

    [[nodiscard]] const byte_t* current() const {
        return _delegate->current();
    }

    byte_t next() {
        return _delegate->next();
    }

    byte_t take() {
        return _delegate->take();
    }

    bool take(size_t size, byte_t* SP_NONNULL* SP_NULLABLE result) {
        return _delegate->take(size, result);
    }

    byte_t peek() {
        return _delegate->peek();
    }

    byte_t peek(size_t offset) {
        return _delegate->peek(offset);
    }

    bool move() {
        return _delegate->move();
    }

    bool move(size_t offset) {
        return _delegate->move(offset);
    }

private:
    delegate_t _delegate;
};

SP_CPP_FILE_END

#endif // START_POINT_STREAM_HPP
