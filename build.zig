const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const lib = b.addStaticLibrary(.{
        .name = "spirv-cross",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.linkLibCpp();
    lib.addCSourceFiles(.{ .files = sources, .flags = &.{
        "-DSPIRV_CROSS_C_API_GLSL",
        "-DSPIRV_CROSS_C_API_HLSL",
        "-DSPIRV_CROSS_C_API_MSL",
    } });
    lib.addIncludePath(b.path("."));
    lib.installHeadersDirectory(b.path("."), "spirv-cross", .{
        .include_extensions = &.{".h"},
    });
    b.installArtifact(lib);
}

const sources = &[_][]const u8{
    "spirv_cpp.cpp",
    "spirv_cfg.cpp",
    "spirv_cross_c.cpp",
    "spirv_cross.cpp",
    "spirv_cross_parsed_ir.cpp",
    "spirv_cross_util.cpp",
    "spirv_glsl.cpp",
    "spirv_hlsl.cpp",
    "spirv_msl.cpp",
    "spirv_parser.cpp",
    "spirv_reflect.cpp",
};
