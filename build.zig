const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const zig_js = b.dependency("zig-js", .{});

    const js_bind = b.addModule("js-bind", .{ .root_source_file = b.path("src/lib.zig") });
    js_bind.addImport("zig-js", zig_js.module("zig-js"));

    const wasm = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("src/main.zig"),
        .target = b.resolveTargetQuery(.{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        }),
        .optimize = optimize,
    });
    wasm.root_module.addImport("js-bind", js_bind);
    wasm.entry = .disabled;
    wasm.rdynamic = true;
    wasm.export_memory = true;

    // custom's path is relative to zig-out
    const wasm_install = b.addInstallFileWithDir(
        wasm.getEmittedBin(),
        .{ .custom = "../dist" },
        "main.wasm",
    );

    b.getInstallStep().dependOn(&wasm_install.step);
}
