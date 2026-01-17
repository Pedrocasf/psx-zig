const std = @import("std");
const PSXBuilder = @import("PSX/builder.zig");

pub fn build(b: *std.Build) void {
    _ = PSXBuilder.addPSXExecutable(b, "first.elf.elf", "examples/first.elf/first.elf.zig");
}
