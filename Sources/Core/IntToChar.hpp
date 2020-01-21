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

#ifndef START_POINT_INT_TO_CHAR_HPP
#define START_POINT_INT_TO_CHAR_HPP

#include <cstdint>
#include <cassert>
#include "include/Config.h"

SP_CPP_FILE_BEGIN

// "00" - "99"
static constexpr char cDigitsLut[200] = {
    '0', '0', '0', '1', '0', '2', '0', '3', '0', '4', '0', '5', '0', '6', '0',
    '7', '0', '8', '0', '9', '1', '0', '1', '1', '1', '2', '1', '3', '1', '4',
    '1', '5', '1', '6', '1', '7', '1', '8', '1', '9', '2', '0', '2', '1', '2',
    '2', '2', '3', '2', '4', '2', '5', '2', '6', '2', '7', '2', '8', '2', '9',
    '3', '0', '3', '1', '3', '2', '3', '3', '3', '4', '3', '5', '3', '6', '3',
    '7', '3', '8', '3', '9', '4', '0', '4', '1', '4', '2', '4', '3', '4', '4',
    '4', '5', '4', '6', '4', '7', '4', '8', '4', '9', '5', '0', '5', '1', '5',
    '2', '5', '3', '5', '4', '5', '5', '5', '6', '5', '7', '5', '8', '5', '9',
    '6', '0', '6', '1', '6', '2', '6', '3', '6', '4', '6', '5', '6', '6', '6',
    '7', '6', '8', '6', '9', '7', '0', '7', '1', '7', '2', '7', '3', '7', '4',
    '7', '5', '7', '6', '7', '7', '7', '8', '7', '9', '8', '0', '8', '1', '8',
    '2', '8', '3', '8', '4', '8', '5', '8', '6', '8', '7', '8', '8', '8', '9',
    '9', '0', '9', '1', '9', '2', '9', '3', '9', '4', '9', '5', '9', '6', '9',
    '7', '9', '8', '9', '9'};

inline char* u32toa(uint32_t value, char* buffer) {
    assert(buffer != nullptr);
    const char* table = cDigitsLut;
    if (value < 1'0000u) {
        const auto d1 = (value / 100u) << 1u;
        const auto d2 = (value % 100u) << 1u;
        if (value >= 1000u) {
            *buffer++ = table[d1];
        }
        if (value >= 100u) {
            *buffer++ = table[d1 + 1u];
        }
        if (value >= 10u) {
            *buffer++ = table[d2];
        }
        *buffer++ = table[d2 + 1u];
    } else if (value < 10000'0000u) {
        const auto b = value / 1'0000u;
        const auto c = value % 1'0000u;

        const auto d1 = (b / 100u) << 1u;
        const auto d2 = (b % 100u) << 1u;
        const auto d3 = (c / 100u) << 1u;
        const auto d4 = (c % 100u) << 1u;

        if (value >= 1000'0000u) {
            *buffer++ = table[d1];
        }
        if (value >= 100'0000u) {
            *buffer++ = table[d1 + 1u];
        }
        if (value >= 10'0000u) {
            *buffer++ = table[d2];
        }
        *buffer++ = table[d2 + 1u];

        *buffer++ = table[d3];
        *buffer++ = table[d3 + 1u];
        *buffer++ = table[d4];
        *buffer++ = table[d4 + 1u];
    } else {
        const auto a = value / 1000'00000u;
        value %= 1000'00000u;
        if (a >= 10u) {
            const auto i = a << 1u;
            *buffer++ = table[i];
            *buffer++ = table[i + 1u];
        } else {
            *buffer++ = '0' + static_cast<char>(a); //  table[a];
        }
        const auto b = value / 1'0000u;
        const auto c = value % 1'0000u;

        const auto d1 = (b / 100u) << 1u;
        const auto d2 = (b % 100u) << 1u;
        const auto d3 = (c / 100u) << 1u;
        const auto d4 = (c % 100u) << 1u;

        *buffer++ = table[d1];
        *buffer++ = table[d1 + 1u];
        *buffer++ = table[d2];
        *buffer++ = table[d2 + 1u];
        *buffer++ = table[d3];
        *buffer++ = table[d3 + 1u];
        *buffer++ = table[d4];
        *buffer++ = table[d4 + 1u];
    }
    return buffer;
}

inline char* i32toa(int32_t value, char* buffer) {
    assert(buffer != nullptr);
    auto u = static_cast<uint32_t>(value);
    if (value < 0) {
        *buffer++ = '-';
        u = ~u + 1u;
    }
    return u32toa(u, buffer);
}

inline char* u64toa(uint64_t value, char* buffer) {
    assert(buffer != nullptr);
    const char* table = cDigitsLut;
    // 1 with 8 zero...
    constexpr auto ten8 = 1'0000'0000llu;
    constexpr auto ten9 = 10'0000'0000llu;
    constexpr auto ten10 = 100'0000'0000llu;
    constexpr auto ten11 = 1000'0000'0000llu;
    constexpr auto ten12 = 1'0000'0000'0000llu;
    constexpr auto ten13 = 10'0000'0000'0000llu;
    constexpr auto ten14 = 100'0000'0000'0000llu;
    constexpr auto ten15 = 1000'0000'0000'0000llu;
    constexpr auto ten16 = 1'0000'0000'0000'0000llu;

    if (value < ten8) {
        auto v = static_cast<uint32_t>(value);
        if (v < 1'0000u) {
            const auto d1 = (v / 100u) << 1u;
            const auto d2 = (v % 100u) << 1u;
            if (v >= 1000u) {
                *buffer++ = table[d1];
            }
            if (v >= 100u) {
                *buffer++ = table[d1 + 1u];
            }
            if (v >= 10u) {
                *buffer++ = table[d2];
            }
            *buffer++ = table[d2 + 1u];
        } else {
            const auto b = v / 1'0000u;
            const auto c = v % 1'0000u;

            const auto d1 = (b / 100u) << 1u;
            const auto d2 = (b % 100u) << 1u;
            const auto d3 = (c / 100u) << 1u;
            const auto d4 = (c % 100u) << 1u;

            if (v >= 1000'0000u) {
                *buffer++ = table[d1];
            }
            if (v >= 100'0000u) {
                *buffer++ = table[d1 + 1u];
            }
            if (v >= 10'0000u) {
                *buffer++ = table[d2];
            }
            *buffer++ = table[d2 + 1u];

            *buffer++ = table[d3];
            *buffer++ = table[d3 + 1u];
            *buffer++ = table[d4];
            *buffer++ = table[d4 + 1u];
        }
    } else if (value < ten16) {
        const auto v0 = static_cast<uint32_t>(value / ten8);
        const auto v1 = static_cast<uint32_t>(value % ten8);

        const auto b0 = v0 / 1'0000u;
        const auto c0 = v0 % 1'0000u;

        const auto d1 = (b0 / 100u) << 1u;
        const auto d2 = (b0 % 100u) << 1u;
        const auto d3 = (c0 / 100u) << 1u;
        const auto d4 = (c0 % 100u) << 1u;

        const auto b1 = v1 / 1'0000u;
        const auto c1 = v1 % 1'0000u;

        const auto d5 = (b1 / 100u) << 1u;
        const auto d6 = (b1 % 100u) << 1u;
        const auto d7 = (c1 / 100u) << 1u;
        const auto d8 = (c1 % 100u) << 1u;

        if (value >= ten15) {
            *buffer++ = table[d1];
        }
        if (value >= ten14) {
            *buffer++ = table[d1 + 1u];
        }
        if (value >= ten13) {
            *buffer++ = table[d2];
        }
        if (value >= ten12) {
            *buffer++ = table[d2 + 1u];
        }
        if (value >= ten11) {
            *buffer++ = table[d3];
        }
        if (value >= ten10) {
            *buffer++ = table[d3 + 1u];
        }
        if (value >= ten9) {
            *buffer++ = table[d4];
        }
        *buffer++ = table[d4 + 1u];

        *buffer++ = table[d5];
        *buffer++ = table[d5 + 1u];
        *buffer++ = table[d6];
        *buffer++ = table[d6 + 1u];
        *buffer++ = table[d7];
        *buffer++ = table[d7 + 1u];
        *buffer++ = table[d8];
        *buffer++ = table[d8 + 1u];
    } else {
        const auto a = static_cast<uint32_t>(value / ten16);
        value %= ten16;

        if (a < 10u) {
            *buffer++ = '0' + static_cast<char>(a); //  table[a];
        } else if (a < 100u) {
            const auto i = a << 1u;
            *buffer++ = table[i];
            *buffer++ = table[i + 1u];
        } else if (a < 1000u) {
            *buffer++ = '0' + static_cast<char>(a / 100u); //  table[a / 100u];
            const auto i = (a % 100u) << 1u;
            *buffer++ = table[i];
            *buffer++ = table[i + 1u];
        } else {
            const auto i = (a / 100u) << 1u;
            const auto j = (a % 100u) << 1u;
            *buffer++ = table[i];
            *buffer++ = table[i + 1u];
            *buffer++ = table[j];
            *buffer++ = table[j + 1u];
        }

        const auto v0 = static_cast<uint32_t>(value / ten8);
        const auto v1 = static_cast<uint32_t>(value % ten8);

        const auto b0 = v0 / 1'0000u;
        const auto c0 = v0 % 1'0000u;

        const auto d1 = (b0 / 100u) << 1u;
        const auto d2 = (b0 % 100u) << 1u;
        const auto d3 = (c0 / 100u) << 1u;
        const auto d4 = (c0 % 100u) << 1u;

        const auto b1 = v1 / 1'0000u;
        const auto c1 = v1 % 1'0000u;

        const auto d5 = (b1 / 100u) << 1u;
        const auto d6 = (b1 % 100u) << 1u;
        const auto d7 = (c1 / 100u) << 1u;
        const auto d8 = (c1 % 100u) << 1u;

        *buffer++ = table[d1];
        *buffer++ = table[d1 + 1u];
        *buffer++ = table[d2];
        *buffer++ = table[d2 + 1u];
        *buffer++ = table[d3];
        *buffer++ = table[d3 + 1u];
        *buffer++ = table[d4];
        *buffer++ = table[d4 + 1u];

        *buffer++ = table[d5];
        *buffer++ = table[d5 + 1u];
        *buffer++ = table[d6];
        *buffer++ = table[d6 + 1u];
        *buffer++ = table[d7];
        *buffer++ = table[d7 + 1u];
        *buffer++ = table[d8];
        *buffer++ = table[d8 + 1u];
    }
    return buffer;
}

inline char* i64toa(int64_t value, char* buffer) {
    assert(buffer != nullptr);
    auto u = static_cast<uint64_t>(value);
    if (value < 0ll) {
        *buffer++ = '-';
        u = ~u + 1u;
    }
    return u64toa(u, buffer);
}

SP_CPP_FILE_END

#endif // START_POINT_INT_TO_CHAR_HPP
