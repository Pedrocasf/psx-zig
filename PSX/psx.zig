pub const Header = @import("core.zig").Header;
pub const puts = @import("BIOS/calls.zig").puts;
pub const Ports = @import("gpu/ports.zig");
pub const GP0Command = Ports.GP0Commands;
pub const GP0Port = Ports.GPU.GP0GPUREAD;
pub const GP0CommandType = Ports.GP0CommandType;
pub const RawMod = Ports.RawMod;