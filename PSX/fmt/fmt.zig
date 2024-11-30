const std = @import("std");
var buffer: [64]u8 = undefined;

pub fn fmtZ(comptime fmt: []const u8,options: std.fmt.FormatOptions,writer: anytype) [*:0]const u8 {
    const formatted = std.fmt.bufPrint(&buffer, s ++ "\n\x00", n) catch "fmtZ error\n\x00";
    return @ptrCast([*:0]const u8, formatted.ptr);
}
