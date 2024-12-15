const js = @import("zig-js");

pub const Element = @This();

object: js.Object,

pub fn deinit(self: Element) void {
    self.object.deinit();
}
