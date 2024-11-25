const Voladdress = @import("../voladdress.zig").Voladdress;
pub const i_stat_mask = packed struct(u32) {
    vblank:bool,
    gpu:bool,
    cdrom:bool,
    dma:bool,
    timer0:bool,
    timer1:bool,
    timer2:bool,
    controller_mc:bool,
    sio:bool,
    spu:bool,
    lightpen:bool,
    zeroed:u5,
    garbage:u16
};
pub const Interrupts = struct {
    pub const I_STAT =Voladdress(u32, i_stat_mask, i_stat_mask, 0x1F801070);
    pub const I_MASK =Voladdress(u32, i_stat_mask, i_stat_mask, 0x1F801074);
};