const js = @import("zig-js");
const Element = @import("Element.zig");

pub const Document = @This();

object: js.Object,

pub fn query_selector(self: Document, query: []const u8) ?Element {
    const result = self.object.call(js.Object, "querySelector", .{js.string(query)}) catch return null;
    if (result.value == js.Value.null) return null;
    return .{ .object = result };
}

pub fn deinit(self: Document) void {
    self.object.deinit();
}
