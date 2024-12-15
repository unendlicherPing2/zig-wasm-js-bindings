const std = @import("std");

pub fn build(b: *std.Build) void {
    const zig_js = b.dependency("zig-js", .{});

    const target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        },
    });

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.rdynamic = true;
    exe.entry = .disabled;

    exe.root_module.addImport("zig-js", zig_js.module("zig-js"));

    b.installArtifact(exe);

    const install_step = b.addInstallArtifact(exe, .{ .dest_dir = .{ .override = .{ .custom = "../dist" } } });
    install_step.step.dependOn(&exe.step);
    b.getInstallStep().dependOn(&install_step.step);
}
