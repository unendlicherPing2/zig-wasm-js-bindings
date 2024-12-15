const js = @import("zig-js");

pub const Console = @This();

object: js.Object,

pub fn log(self: Console, args: anytype) !void {
    return try self.object.call(void, "log", args);
}

pub fn debug(self: Console, args: anytype) !void {
    return try self.object.call(void, "debug", args);
}

pub fn perror(self: Console, args: anytype) !void {
    return try self.object.call(void, "error", args);
}

pub fn info(self: Console, args: anytype) !void {
    return try self.object.call(void, "info", args);
}

pub fn warn(self: Console, args: anytype) !void {
    return try self.object.call(void, "warn", args);
}

pub fn deinit(self: Console) void {
    self.object.deinit();
}
