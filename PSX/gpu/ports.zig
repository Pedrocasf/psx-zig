const Font = @embedFile("../../PSX-Font.raw");
const Voladdress = @import("../voladdress.zig").Voladdress;
const GP0Command = @import("GP0Command.zig").GP0Command;
const GPURead = @import("GPURead.zig").GPURead;
const GP1Command = @import("GP1Commands.zig").GP1Command;
const GPUStatus = @import("GPUStatus.zig").GPUStatus;
const GPU = struct {
    pub const GP0GPUREAD = Voladdress(u32, GPURead, GP0Command, 0x1F801810);
    pub const GP1GPUSTAT = Voladdress(u32, GPUStatus, GP1Command, 0x1F801810);
};
