#ifndef START_POINT_CONFIG_H
#define START_POINT_CONFIG_H

#ifdef __cplusplus
#define SP_EXTERN_C_BEGIN extern "C" {
#define SP_EXTERN_C_END }

#define SP_NAMESPACE_BEGIN namespace StartPoint {
#define SP_NAMESPACE_END }
#else
#define SP_EXTERN_C_BEGIN
#define SP_EXTERN_C_END

#define SP_NAMESPACE_BEGIN
#define SP_NAMESPACE_END
#endif

#define SP_C_FILE_BEGIN SP_EXTERN_C_BEGIN \
_Pragma("clang assume_nonnull begin")
#define SP_C_FILE_END _Pragma("clang assume_nonnull end") \
SP_EXTERN_C_END

#if defined(__clang__) || defined(__GNUC__)
#define SP_LIKELY(x) __builtin_expect(!!(x), 1)
#define SP_UNLIKELY(x) __builtin_expect(!!(x), 0)
#else
#define SP_LIKELY(x) (x)
#define SP_UNLIKELY(x) (x)
#endif

#endif //START_POINT_CONFIG_H
