const std = @import("std");
const builtin = @import("builtin");

pub fn debug_print(fmt: []const u8, args: anytype) void {
    if (builtin.mode == .Debug) {
        std.debug.print(fmt, args);
    }
}
