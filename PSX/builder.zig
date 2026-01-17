const std = @import("std");
const PSXLinkerScript = libRoot() ++ "/psx.ld";
const PSXLibFile = libRoot() ++ "/psx.zig";

fn libRoot() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
const psx_target_query = blk: {
    var target = std.Target.Query{
        .cpu_arch = std.Target.Cpu.Arch.mipsel,
        .cpu_model = .{ .explicit = &std.Target.mips.cpu.mips1 },
        .os_tag = .freestanding
    };
    target.cpu_features_add.addFeature(@intFromEnum(std.Target.mips.Feature.soft_float));
    break :blk target;
};
pub fn addPSXStaticLibrary(b: *std.Build, libraryName: []const u8, sourceFile: []const u8) *std.Build.Step.Compile {
    const lib = b.addLibrary(.{
        .name = libraryName,
        .root_module = b.createModule(.{
            .root_source_file = b.path(sourceFile),
            .target = b.resolveTargetQuery(psx_target_query),
            .optimize = .ReleaseFast,
            .single_threaded = true,
            .link_libc = false,
            .strip = true,
        }),
    .   linkage = .static,
    });
    lib.setLinkerScript(.{ .cwd_relative = PSXLinkerScript});
    return lib;
}
pub fn createPSXLib(b: *std.Build) *std.Build.Step.Compile {
    return addPSXStaticLibrary(b, "ZigPSX", PSXLibFile);
}
pub fn addPSXExecutable(b: *std.Build, romName: []const u8, sourceFile: []const u8 ) *std.Build.Step.Compile {
    const exe = b.addExecutable(.{
        .name = romName,
        .root_module = b.createModule(.{
            .root_source_file = b.path(sourceFile),
            .target = b.resolveTargetQuery(psx_target_query),
            .optimize = .ReleaseFast,
            .single_threaded = true,
            .link_libc = false,
            .strip = true,
            }),
        .linkage = .static,

    });
    exe.setLinkerScript(.{.cwd_relative = PSXLinkerScript});
    exe.verbose_cc = true;
    exe.verbose_link = true;
    //const objcopy_step = exe.addObjCopy(.{
    //    .format = .elf,
    //});

    //const install_bin_step = b.addInstallBinFile(objcopy_step.getOutput(), b.fmt("{s}.elf", .{romName}));
    //install_bin_step.step.dependOn(&objcopy_step.step);

    //b.default_step.dependOn(&install_bin_step.step);

    const psxLib = createPSXLib(b);
    exe.root_module.addAnonymousImport("ZigPSX", .{ .root_source_file = b.path(PSXLibFile) });
    exe.root_module.linkLibrary(psxLib);
    exe.root_module.single_threaded = true;
    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
    return exe;
}
