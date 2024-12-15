const js = @import("zig-js");

pub const Console = @import("./Console.zig");
pub const Document = @import("./Document.zig");
pub const Element = @import("./Element.zig");
pub const Util = struct {
    pub fn string(s: []const u8) js.String {
        return js.string(s);
    }
};

pub fn console() !Console {
    return .{ .object = try js.global.get(js.Object, "console") };
}

pub fn document() !Document {
    return .{ .object = try js.global.get(js.Object, "document") };
}
