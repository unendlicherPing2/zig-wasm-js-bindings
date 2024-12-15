const js = @import("js-bind");

export fn run() void {
    const console = js.console() catch unreachable;
    defer console.deinit();

    console.log(.{js.Util.string("Hello, log!")}) catch unreachable;
    console.info(.{js.Util.string("Hello, info!")}) catch unreachable;
    console.debug(.{js.Util.string("Hello, debug!")}) catch unreachable;
    console.warn(.{js.Util.string("Hello, warn!")}) catch unreachable;
    console.perror(.{js.Util.string("Hello, perror!")}) catch unreachable;

    const document = js.document() catch unreachable;
    defer document.deinit();

    const body = document.query_selector("body") orelse unreachable;
    defer body.deinit();

    console.debug(.{ js.Util.string("body"), body.object }) catch unreachable;
}
