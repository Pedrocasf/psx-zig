const root = @import("root");
extern var __text_start:u8;
extern var __bss_end:u8;
extern var __bss_start:u8;
extern var __data_start:u8;
extern var __data_end:u8;
pub const PSX = struct {
    pub const Header = extern struct {
        magic: [8]u8 align(1),
        zeros: [8]u8 align(1),
        pc: u32 align(1),
        gp: u32 align(1),
        ram_addr: u32 align(1),
        filesize: u32 align(1),
        data_start: u32 align(1),
        data_size: u32 align(1),
        bss_start: u32 align(1),
        bss_size: u32 align(1),
        sp_fp_base:u32 align(1),
        sp_fp_offset:u32 align(1),
        zeroed: [1992]u8 align(1),

        pub fn setup() Header{
            comptime {
                const file_size:usize = @as(usize, @bitCast(@intFromPtr(&__bss_end))) - @as(usize, @bitCast(@intFromPtr(&__text_start)));
                const data_size:usize = @as(usize, @bitCast(@intFromPtr(&__data_end))) - @as(usize, @bitCast(@intFromPtr(&__data_start)));
                const bss_size:usize = @as(usize, @bitCast(@intFromPtr(&__bss_end))) - @as(usize, @bitCast(@intFromPtr(&__bss_start)));
                const header = Header{
                    .magic = .{80, 83, 45, 32, 69, 88, 64, 0},
                    .zeros = [_]u8{0} ** 8,
                    .pc = @bitCast(@intFromPtr(&__text_start)),
                    .gp = 0,
                    .ram_addr = @bitCast(@intFromPtr(&__text_start)),
                    .filesize = ((file_size % 0x800) + 1) * 0x800,
                    .data_start = @bitCast(@intFromPtr(&__data_start)),
                    .data_size = data_size,
                    .bss_start = @bitCast(@intFromPtr(&__bss_start)),
                    .bss_size = bss_size,
                    .sp_fp_base = 0x801FFFF0,
                    .sp_fp_offset = 0x0000000,
                    .zeroed = [_]u8{0} ** 1992
                };
                return header;
            }
        }
    };
};
export fn start() linksection(".psxmain") callconv(.C) noreturn {
    // call user's main
    if (@hasDecl(root, "main")) {
        root.main();
    }
    unreachable;
}
