const js = @import("zig-js");

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

export fn print() void {
    const console = js.global.get(js.Object, "console") catch return;
    defer console.deinit();

    console.call(void, "log", .{js.string("Hello, world!")}) catch return;
}
