const std = @import("std");

// cli tool to reply to a message
pub fn main() !void {
    var args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    for (args, 0..) |arg, i| {
        std.debug.print("arg {d}: {s}\n", .{ i, arg });
    }
}
