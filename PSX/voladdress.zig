const std = @import("std");
const assert = std.debug.assert;
pub fn Voladdress(comptime T: type, comptime R: type, comptime W: type, comptime A: comptime_int) type {
    assert(@bitSizeOf(T) == @bitSizeOf(R));
    assert(@bitSizeOf(T) == @bitSizeOf(W));
    return struct {
        const r: *volatile T = @ptrFromInt(A);
        const VolAddress = @This();
        raw: r,
        pub fn read(v: VolAddress) R {
            return @bitCast(v.*);
        }
        pub fn write(v: VolAddress, data: W) void {
            v.raw.* = @bitCast(data);
        }
    };
}
