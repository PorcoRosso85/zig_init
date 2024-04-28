const std = @import("std");
const builtin = @import("builtin");

const dp = @import("./debug_print.zig").debug_print;

pub fn main() void {
    var user = User{
        .id = 1,
        .power = 100,
    };
    user.power += 0;

    const user_p = &user;
    dp("{any}\n", .{@TypeOf(user_p)});
    dp("main: {d}\n", .{&user});

    levelUp(&user);
    std.debug.print("User {d} has power of {d}\n", .{ user.id, user.power });
}

fn levelUp(user: *User) void {
    // std.debug.print("levelUp: {*}\n", .{&user});
    // var u = user;
    // u.power += 1;
    user.power += 1;
}

pub const User = struct {
    id: u64,
    power: i32,
};
