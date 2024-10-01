pub const Color = packed struct(u24) { Red: u8, Green: u8, Blue: u8 };
pub const MiscCommands = packed struct(u29) {
    commnad: enum(u5) { None, ClearCache, QuickRectangleFill },
    args: union(u24) {
        color: Color,
    },
};
pub const GouradFlat = enum(u1) { Flat, Gourad };
pub const SemiTransparentOpaque = enum(u1) { Opaque, SemiTransparent };
pub const RawModulated = enum(u1) { Modulated, RawTexture };
pub const TexturedUntextured = enum(u1) { Untextured, Textured };
pub const PolygonRender = packed struct(u29) {
    rgb: Color,
    raw_or_modulated: RawModulated,
    semi_transparent_or_opaque: SemiTransparentOpaque,
    terxtured_or_untextured: enum(u1) { Untextured, Textured },
    vertices_3_or_4: enum(u1) { Three, Four },
    sahding_gourad_or_flat: GouradFlat,
};
pub const LineRender = packed struct(u29) {
    rgb: Color,
    shading_gourad_or_flat: GouradFlat,
    polyline_or_singleline: enum(u1) { SingleLine, PolyLine },
    semi_transparent_or_opaque: SemiTransparentOpaque,
};
pub const RectangleRender = packed struct(u29) {
    color: Color,
    raw_or_modulated: RawModulated,
    semi_transparent_or_opaque: SemiTransparentOpaque,
    textured_or_untextured: TexturedUntextured,
    size: enum(u2) { Variable, SinglePx, EightPx, SixteenPx },
};
pub const Texpage = packed struct(u24) {
    texpage_base_x: u4,
    texpage_base_y_1: enum(u1) {
        Zero,
        TwoFiveSix,
    },
    semi_transparency: u2,
    texpage_colors: enum(u2) {
        FourBit,
        EightBit,
        SixteenBits,
        Reserved,
    },
    dither: enum(u1) {
        StripLSBs,
        Dither,
    },
    draw_to_display_area: bool,
    texpage_base_y_2: enum(u1) {
        Zero,
        FiveOneTwo,
    },
    texture_rectangle_x_flip: bool,
    texture_rectangle_y_flip: bool,
    padding: u10,
};
pub const TextureWindow = packed struct(u24) {
    TexMaskX: u5,
    TexMaskY: u5,
    TexOffsetX: u5,
    TexOffsetY: u5,
    _padding: u4,
};
pub const EnvironmentCommands = packed struct(u29) {
    args: union(u24) {
        texpage: Texpage,
        texwindow: TextureWindow,
    },
    commnad: enum(u5) {
        Nop,
        TexpageDrawMode,
        TextureWindow,
        DrawingAreaTopLeft,
        DrawingAreaBottomRight,
        DrawingOffset,
        MaskBit,
    },
};
pub const GP0Command = packed struct(u32) {
    commnad_type: enum(u3) {
        Misc,
        PolygonPrimitive,
        LinePrimitive,
        RectanglePrimmitive,
        VRAM2VRAMBlit,
        CPU2VRAMBlit,
        VRAM2CPUBlit,
        Environment,
    },
    command: union(u29) {
        misc: MiscCommands,
        polygon_render: PolygonRender,
        line_render: LineRender,
        rectangle_render: RectangleRender,
    },
};

pub const GP0: *volatile GP0Command = @ptrFromInt(0x1F801810);
pub const ctrl = @intToPtr(*volatile u32, 0x1f801814);
