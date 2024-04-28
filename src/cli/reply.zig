const std = @import("std");

pub fn reply(args: [][:0]u8) !void {
    for (args, 0..) |arg, i| {
        std.debug.print("arg {d}: {s}\n", .{ i, arg });
    }
}
