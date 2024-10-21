const voladdress = @import("../voladdress.zig").Voladdress;
const std = @import("std");
const assert = std.debug.assert;

pub fn DMA(comptime Num: u3) type {
    assert(Num <= 6);
    return struct {
        const DMA_ADR: *volatile u24 = @ptrFromInt(0x1F801080 + (Num * 16));
        const DMA_BCR: *volatile .{ u16, u16 } = @ptrFromInt(0x1F801084 + (Num * 16));
        const DMA_CHCR: *volatile u32 = @ptrFromInt(0x1F801088 + (Num * 16));
        const VolAddress = @This();
        pub fn read_adr(this: DMA) u24 {
            return this.DMA_ADR.*;
        }
        pub fn read_bcr(this: DMA) .{ u16, u16 } {
            return this.DMA_BCR.*;
        }
    };
}
