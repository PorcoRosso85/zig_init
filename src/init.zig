const std = @import("std");

// add function
pub fn add(a: i32, b: i32) i32 {
    @breakpoint();
    return a + b;
}

// test add function
test "add function" {
    try std.testing.expectEqual(add(1, 2), 3);
}

pub fn main() !void {
    _ = add(1, 2);
    std.debug.print("add(1, 2) = {}\n", .{add(1, 2)});
}
