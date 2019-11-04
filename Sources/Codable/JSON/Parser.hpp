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

#ifndef START_POINT_PARSER_HPP
#define START_POINT_PARSER_HPP

#include "JSON.hpp"
#include "Stream.hpp"
#include "Double.h"

#ifndef SP_JSON_PARSER_USE_STD_STOD
#define SP_JSON_PARSER_USE_STD_STOD 1
#endif

SP_CPP_FILE_BEGIN

class Parser final {
public:
    using value_t = JSON<std::allocator>;
    using byte_t = ByteStream::byte_t;
    using size_t = ByteStream::size_t;
    using stream_t = ByteStreams;

    explicit Parser(value_t& root, stream_t&& stream)
        : _root(root), _stack(), _current(nullptr), _stream(std::move(stream)) {}

    Parser(const Parser&) = delete;

    Parser(Parser&&) = default;

    Parser& operator=(const Parser&) = delete;

    Parser& operator=(Parser&&) = delete;

    //  n,  t,  f,  ",  [,  {
    // [6e, 74, 66, 22, 5b, 7b]
    void parse() {
        switch (_stream.peek()) {
            case 0x6e:
                parseNull();
                break;
            case 0x74:
                parseTrue();
                break;
            case 0x66:
                parseFalse();
                break;
            case 0x22:
                parseString();
                break;
            case 0x7b:
                parseObject();
                break;
            case 0x5b:
                parseArray();
                break;
            default:
                parseNumber();
                break;
        }
    }

private:
    //  n,  u,  l,  l
    // [6e, 75, 6c, 6c]
    void parseNull() {
        if (consume(0x6e) && consume(0x75) && consume(0x6c) && consume(0x6c)) {
            append(value_t{});
        }
    }

    //  t,  r,  u,  e
    // [74, 72, 75, 65]
    void parseTrue() {
        if (consume(0x74) && consume(0x72) && consume(0x75) && consume(0x65)) {
            append(value_t{true});
        } else {
            throw std::runtime_error("JSONParseError.valueInvalid");
        }
    }

    //  f,  a,  l,  s,  e
    // [66, 61, 6c, 73, 65]
    void parseFalse() {
        if (consume(0x66) && consume(0x61) && consume(0x6c) && consume(0x73) && consume(0x65)) {
            append(value_t{false});
        } else {
            throw std::runtime_error("JSONParseError.valueInvalid");
        }
    }

    void parseString() {
        if (!consume(0x22)) {
            throw std::runtime_error("JSONParseError.valueInvalid");
        }
        append(value_t{JSONTypeString});
        Scope scope{[&]() {
            assert(!_stack.empty());
            auto value = _stack.back();
            assert(value->isString());
            _stack.pop_back();
            _current = _stack.back();
        }};
        rawString();
        if (!consume(0x22)) {
            throw std::runtime_error("JSONParseError.valueInvalid");
        }
    }

    //  -,  0,  1,  9,  .
    // [2d, 30, 31, 39, 2e]
    void parseNumber() {
        auto minus = consume(0x2d);
        uint32_t i = 0;
        uint64_t i64 = 0;
#if (SP_JSON_PARSER_USE_STD_STOD)
        auto start = _stream.current();
#else
        int32_t significandDigit = 0;
#endif
        auto use64bit = false;
        auto next = static_cast<uint32_t>(_stream.peek());
        switch (next) {
            case 0x30:
                _stream.move();
                break;
            case 0x31:
            case 0x32:
            case 0x33:
            case 0x34:
            case 0x35:
            case 0x36:
            case 0x37:
            case 0x38:
            case 0x39: {
                i = next - 0x30;
                next = static_cast<uint32_t>(_stream.next());
                if (minus) {
                    while (0x30 <= next && next <= 0x39) {
                        if (i >= 214748364) { // 2^31 = 2147483648
                            if (i != 214748364 || next > 0x38) {
                                i64 = i;
                                use64bit = true;
                                break;
                            }
                        }
                        i = i * 10 + (next - 0x30);
#if !(SP_JSON_PARSER_USE_STD_STOD)
                        significandDigit += 1;
#endif
                        next = static_cast<uint32_t>(_stream.next());
                    }
                } else {
                    while (0x30 <= next && next <= 0x39) {
                        if (i >= 429496729) { // 2^32 - 1 = 4294967295
                            if (i != 429496729 || next > 0x35) {
                                i64 = i;
                                use64bit = true;
                                break;
                            }
                        }
                        i = i * 10 + (next - 0x30);
#if !(SP_JSON_PARSER_USE_STD_STOD)
                        significandDigit += 1;
#endif
                        next = static_cast<uint32_t>(_stream.next());
                    }
                }
            }
                break;
            default:
                throw std::runtime_error("JSONParseError.valueInvalid");
        }
        auto useDouble = false;
#if !(SP_JSON_PARSER_USE_STD_STOD)
        double floating = 0.0;
#endif
        if (use64bit) {
            if (minus) {
                while (0x30 <= next && next <= 0x39) {
                    if (i64 >= 922337203685477580) { // 2^63 = 9223372036854775808
                        if (i64 != 922337203685477580 || next > 0x38) {
#if !(SP_JSON_PARSER_USE_STD_STOD)
                            floating = i64;
#endif
                            useDouble = true;
                            break;
                        }
                    }
                    i64 = i64 * 10 + (next - 0x30);
#if !(SP_JSON_PARSER_USE_STD_STOD)
                    significandDigit += 1;
#endif
                    next = static_cast<uint32_t>(_stream.next());
                }
            } else {
                while (0x30 <= next && next <= 0x39) {
                    if (i64 >= 1844674407370955161) { // 2^64 - 1 = 18446744073709551615
                        if (i64 != 1844674407370955161 || next > 0x35) {
#if !(SP_JSON_PARSER_USE_STD_STOD)
                            floating = i64;
#endif
                            useDouble = true;
                            break;
                        }
                    }
                    i64 = i64 * 10 + (next - 0x30);
#if !(SP_JSON_PARSER_USE_STD_STOD)
                    significandDigit += 1;
#endif
                    next = static_cast<uint32_t>(_stream.next());
                }
            }
        }
        if (useDouble) {
            while (0x30 <= next && next <= 0x39) {
#if !(SP_JSON_PARSER_USE_STD_STOD)
                floating = floating * 10 + (next - 0x30);
#endif
                next = static_cast<uint32_t>(_stream.next());
            }
        }
#if !(SP_JSON_PARSER_USE_STD_STOD)
        int32_t frac = 0;
#endif
        if (consume(0x2e)) {
            next = static_cast<uint32_t>(_stream.peek());
            if (next < 0x30 || next > 0x39) {
                throw std::runtime_error("JSONParseError.numberMissFraction");
            }
            if (!useDouble) {
                if (!use64bit) {
                    i64 = i;
                }
                while (0x30 <= next && next <= 0x39) {
                    if (i64 > 0x1F'FFFF'FFFF'FFFF) { // 2^53 - 1
                        break;
                    }
                    i64 = i64 * 10 + (next - 0x30);
#if !(SP_JSON_PARSER_USE_STD_STOD)
                    frac -= 1;
                    if (i64 != 0) {
                        significandDigit += 1;
                    }
#endif
                    next = static_cast<uint32_t>(_stream.next());
                }
#if !(SP_JSON_PARSER_USE_STD_STOD)
                floating = i64;
#endif
                useDouble = true;
            }
            while (0x30 <= next && next <= 0x39) {
#if !(SP_JSON_PARSER_USE_STD_STOD)
                if (significandDigit < 17) {
                    floating = floating * 10 + (next - 0x30);
                    frac -= 1;
                    if (floating > 0) {
                        significandDigit += 1;
                    }
                }
#endif
                next = static_cast<uint32_t>(_stream.next());
            }
        }
#if !(SP_JSON_PARSER_USE_STD_STOD)
        // Parse exp = e [ minus / plus ] 1*DIGIT
        int32_t exp = 0;
#endif
        if (consume(0x65) || consume(0x45)) { // e, E
#if (SP_JSON_PARSER_USE_STD_STOD)
            useDouble = true;
            consume(0x2b); // +
            consume(0x2d); // -
#else
            if (!useDouble) {
                floating = static_cast<double>(use64bit ? i64 : i);
                useDouble = true;
            }
            auto expMinus = false;
            if (consume(0x2b)) { // +
                // Do nothing.
            } else if (consume(0x2d)) { // -
                expMinus = true;
            }
#endif
            auto item = _stream.peek();
            if (0x30 <= item && item <= 0x39) {
#if (SP_JSON_PARSER_USE_STD_STOD)
                while (0x30 <= item && item <= 0x39) {
                    // Consume the rest of exponent
                    item = _stream.next();
                }
#else
                exp = item - 0x30;
                item = _stream.next();
                if (expMinus) {
                    assert(frac <= 0);
                    const int32_t maxExp = (frac + 2147483639) / 10;
                    while (0x30 <= item && item <= 0x39) {
                        exp = exp * 10 + (next - 0x30);
                        if (exp > maxExp) {
                            while (0x30 <= item && item <= 0x39) {
                                // Consume the rest of exponent
                                item = _stream.next();
                            }
                        }
                        item = _stream.next();
                    }
                } else {
                    const int32_t maxExp = 308 - frac;
                    while (0x30 <= item && item <= 0x39) {
                        exp = exp * 10 + (next - 0x30);
                        if (exp > maxExp) {
                            throw std::runtime_error("JSONParseError.numberTooBig");
                        }
                        item = _stream.next();
                    }
                }
#endif
            } else {
                throw std::runtime_error("JSONParseError.numberMissExponent");
            }
#if !(SP_JSON_PARSER_USE_STD_STOD)
            if (expMinus) {
                exp = -exp;
            }
#endif
        }
        if (useDouble) {
#if (SP_JSON_PARSER_USE_STD_STOD)
            auto last = _stream.current();
            char* end;
            auto floating = std::strtod(reinterpret_cast<const char*>(start), &end);
            assert(last == reinterpret_cast<uint8_t*>(end));
            if (last != reinterpret_cast<uint8_t*>(end)) {
                throw std::runtime_error("JSONParseError.valueInvalid");
            }
#else
            floating = parse_double(floating, exp + frac);
#endif
            if (minus) {
                append(value_t{-floating});
            } else {
                append(value_t{floating});
            }
        } else if (use64bit) {
            if (minus) {
                append(value_t{static_cast<int64_t>(~i64 + 1)});
            } else {
                append(value_t{i64});
            }
        } else {
            if (minus) {
                append(value_t{static_cast<int32_t>(~i + 1)});
            } else {
                append(value_t{i});
            }
        }
    }

    //  {,  },  ",  :,  ,
    // [7b, 7d, 22, 3a, 2c]
    void parseObject() {
        auto start = consume(0x7b);
        assert(start);
        skip();
        append(value_t{JSONTypeObject});
        Scope scope{[&]() {
            assert(!_stack.empty());
            auto value = _stack.back();
            assert(value->isObject());
            _stack.pop_back();
            _current = _stack.back();
        }};
        size_t count = 0;
        if (consume(0x7d)) {
            return;
        }
        while (true) {
            if (!consume(0x22)) {
                throw std::runtime_error("JSONParseError.objectMissName");
            }
            skip();
            parseString();
            skip();
            if (!consume(0x3a)) {
                throw std::runtime_error("JSONParseError.objectMissColon");
            }
            skip();
            parse();
            count += 2;
            skip();
            switch (_stream.peek()) {
                case 0x2c:
                    _stream.move();
                    skip();
                    break;
                case 0x7d:
                    _stream.move();
                    return;
                default:
                    throw std::runtime_error("JSONParseError.objectMissCommaOrCurlyBracket");
            }
        }
    }

    //  [,  ],  ,
    // [5b, 5d, 2c]
    void parseArray() {
        auto start = consume(0x5b);
        assert(start);
        skip();
        append(value_t{JSONTypeArray});
        Scope scope{[&]() {
            assert(!_stack.empty());
            auto value = _stack.back();
            assert(value->isArray());
            _stack.pop_back();
            _current = _stack.back();
        }};
        if (consume(0x5d)) {
            return;
        }
        while (true) {
            parse();
            skip();
            if (consume(0x2c)) {
                skip();
            } else if (consume(0x5d)) {
                return;
            } else {
                throw std::runtime_error("JSONParseError.arrayMissCommaOrSquareBracket");
            }
        }
    }

    //  \,  ",  b,  f,  n,  r,  t,  /,  u
    // [5c, 22, 62, 66, 6e, 72, 74, 2f, 75]
    void rawString() {
        auto next = _stream.peek();
        while (true) {
            switch (next) {
                case 0x5c:
                    next = _stream.next();
                    if (next == 0x75) {
                        parseUnicode();
                    } else {
                        auto value = parseChar();
                        append(value);
                    }
                    break;
                case 0x22:
                    return;
                case 0x00:
                    throw std::runtime_error("JSONParseError.missQuotationMark");
                case 0x01:
                case 0x02:
                case 0x03:
                case 0x04:
                case 0x05:
                case 0x06:
                case 0x07:
                case 0x08:
                case 0x09:
                case 0x10:
                case 0x11:
                case 0x12:
                case 0x13:
                case 0x14:
                case 0x15:
                case 0x16:
                case 0x17:
                case 0x18:
                case 0x19:
                case 0x20:
                    throw std::runtime_error("JSONParseError.missQuotationMark");
                default:
                    append(next);
                    _stream.move();
            }
            next = _stream.peek();
        }
    }

    // Single escape Character
    //  ",  \,  /,  b,  f,  n,  r,  t
    // [22, 5c, 2f, 62, 66, 6e, 72, 74]
    //  \b, \f, \n, \r, \t
    // [08, 0c, 0a, 0d, 09]
    uint8_t parseChar() {
        switch (_stream.peek()) {
            case 0x22:
                _stream.move();
                return 0x22;
            case 0x5c:
                _stream.move();
                return 0x5c;
            case 0x2f:
                _stream.move();
                return 0x2f;
            case 0x62:
                _stream.move();
                return 0x08;
            case 0x66:
                _stream.move();
                return 0x0c;
            case 0x6e:
                _stream.move();
                return 0x0a;
            case 0x72:
                _stream.move();
                return 0x0d;
            case 0x74:
                _stream.move();
                return 0x09;
            default:
                throw std::runtime_error("JSONParseError.stringEscapeInvalid");
        }
    }

    void parseUnicode() {
        auto code = parseUnicodeValue();
        if (SP_UNLIKELY(code >= 0xd800u && code <= 0xdbffu)) {
            // Handle UTF-16 surrogate pair
            if (!consume(0x5c) || _stream.peek() != 0x75) { // "\"
                throw std::runtime_error("JSONParseError.stringUnicodeSurrogateInvalid");
            }
            const auto next = parseUnicodeValue();
            if (SP_UNLIKELY(code >= 0xdc00u && code <= 0xdfffu)) {
                throw std::runtime_error("JSONParseError.stringUnicodeSurrogateInvalid");
            }
            code = (((code - 0xd800u) << 10u) | (next - 0xdc00u)) + 0x10000u;
        }
        if (code <= 0x7f) {
            append(static_cast<uint8_t>(code & 0xffu));
        } else if (code <= 0x7ff) {
            append(static_cast<uint8_t>(0xc0u | ((code >> 6u) & 0xffu)));
            append(static_cast<uint8_t>(0x80u | (code & 0x3fu)));
        } else if (code <= 0xffff) {
            append(static_cast<uint8_t>(0xe0u | ((code >> 12u) & 0xffu)));
            append(static_cast<uint8_t>(0x80u | ((code >> 6u) & 0x3fu)));
            append(static_cast<uint8_t>(0x80u | (code & 0x3fu)));
        } else if (code <= 0x10'ffff) {
            append(static_cast<uint8_t>(0xf0u | ((code >> 18u) & 0xffu)));
            append(static_cast<uint8_t>(0x80u | ((code >> 12u) & 0x3fu)));
            append(static_cast<uint8_t>(0x80u | ((code >> 6u) & 0x3fu)));
            append(static_cast<uint8_t>(0x80u | (code & 0x3fu)));
        } else {
            throw std::runtime_error("JSONParseError.valueInvalid");
        }
    }

    //  u
    // [75]
    uint32_t parseUnicodeValue() {
        auto start = consume(0x75);
        assert(start);
        uint32_t point = 0;
        for (int i = 0; i < 4; ++i) {
            point <<= 4u;
            auto next = _stream.peek();
            point += next;
            if (0x30 <= next && next <= 0x39) { // 0-9
                point -= 0x30;
            } else if (0x41 <= next && next <= 0x46) { // A-F
                point -= 0x41 - 10;
            } else if (0x61 <= next && next <= 0x66) { // a-f
                point -= 0x61 - 10;
            } else {
                throw std::runtime_error("JSONParseError.stringUnicodeEscapeInvalidHex");
            }
            _stream.move();
        }
        return point;
    }

    bool consume(size_t value) {
        if (_stream.peek() == value) {
            _stream.move();
            return true;
        }
        return false;
    }

    // ' ', \n, \r, \t
    // [20, 0a, 0d, 09]
    void skip() {
        auto next = _stream.peek();
        while (next == 0x20 || next == 0x0a || next == 0x0d || next == 0x09) {
            next = _stream.next();
        }
    }

private:
    struct Scope {
        std::function<void(void)> function;

        explicit Scope(std::function<void(void)>&& method) : function(std::move(method)) {}

        ~Scope() {
            function();
        }
    };

    void append(value_t&& value) {
        if (_current == nullptr) {
            _root = std::move(value);
            _current = &_root;
            if (_root.isComplex()) {
                _stack.push_back(_current);
            }
            return;
        }
        switch (_current->type()) {
            case JSONTypeArray:
            case JSONTypeObject: {
                auto& next = _current->append(std::move(value));
                if (next.isComplex()) {
                    _current = &next;
                    _stack.push_back(_current);
                }
                break;
            }
            default:
                break;
        }
    }

    inline void append(uint8_t value) {
        assert(_current != nullptr && _current->isString());
        _current->appendChar(value);
    }

    value_t& _root;
    std::vector<value_t*> _stack;
    value_t* _current;
    stream_t _stream;
};

SP_CPP_FILE_END

#endif // START_POINT_PARSER_HPP
