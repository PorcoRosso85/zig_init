const std = @import("std");
const reply = @import("./cli//reply.zig").reply;

// cli tool to reply to a message
pub fn main() !void {
    var args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);
    try reply(args);
}
