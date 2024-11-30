const Font = @embedFile("../../PSX-Font.raw");
const Voladdress = @import("../voladdress.zig").Voladdress;
pub const GP0Commands = @import("GP0Command.zig");
pub const GP0Cmd = GP0Commands.GP0Command;
pub const GP0CommandType = GP0Commands.CommandType;
pub const RawMod = GP0Commands.RawModulated;
pub const GPURead = @import("GPURead.zig").GPURead;
pub const GP1Commands = @import("GP1Commands.zig");
pub const GP1Cmd = GP1Commands.GP1Command;
pub const GPUStatus = @import("GPUStatus.zig").GPUStatus;
pub const GPU = struct {
    pub const GP0GPUREAD = Voladdress(u32, GPURead, GP0Cmd, 0x1F801810);
    pub const GP1GPUSTAT = Voladdress(u32, GPUStatus, GP1Cmd, 0x1F801810);
};
