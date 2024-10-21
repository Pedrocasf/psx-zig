pub const VramSize = packed struct(u24) {
    VramSize: bool,
};
pub const ReadGpu = packed struct(u24) {
    ReadStat: enum(u3) {
        Nothing0,
        Nothing1,
        TextureWindow,
        DrawAreaTopLeft,
        DrawAreaBottomRight,
        DrawAreaOffset,
        Nothing6,
        Nothing7,
    },
};
pub const DispMode = packed struct(u24) {
    HorizRes: u2,
    VertRez: bool,
    VideoMode: bool,
    DisplayAreaColorDepth: bool,
    VerticalInterlace: bool,
    HorizRes2: bool,
};
pub const VertRange = packed struct(u24) {
    Y1: u10,
    Y2: u10,
};
pub const HorizRange = packed struct(u24) {
    X1: u12,
    X2: u12,
};
pub const DispArea = packed struct(u24) {
    X: u10,
    Y: u10,
};
pub const DirDMA = packed struct(u24) {
    direction: enum(u2) {
        Off,
        FIFO,
        CPU2GP0,
        GPUR2CPU,
    },
};
pub const DispEn = packed struct(u24) {
    DisplayEnable: bool,
};
pub const GP1Command = packed struct(u32) {
    data: union(u24) {
        dispEn: DispEn,
        dirDMA: DirDMA,
        dispArea: DispArea,
        horizRange: HorizRange,
        vertRange: VertRange,
        vramSize: VramSize,
    },
    command: enum(u8) {
        Reset = 0x00,
        ClearFifo = 0x01,
        AckIrq1 = 0x02,
        DispEn = 0x03,
        DirDMA = 0x04,
        DispArea = 0x05,
        HorizRange = 0x06,
        VertRange = 0x07,
        DispMode = 0x08,
        SetVRAMSizeV2 = 0x09,
        ReadGpu = 0x10,
    },
};
