const expect = @import("std").testing.expect;

test "zig test" {
    const c: i32 = 5;
    // try expect(c == 5);
    _ = c;

    var v: i32 = 5000;
    _ = v;

    const ic = @as(i32, 5);
    _ = ic;

    const l1 = [5]u8{ 1, 2, 3, 4, 5 };
    try expect(l1.len == 5);

    const l2 = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    _ = l2;
}

test "if statement" {
    if (true) {
        try expect(true);
    } else {
        try expect(false);
    }

    if (false) {
        try expect(false);
    } else {
        try expect(true);
    }

    var x: u16 = if (true) 5 else 10;
    try expect(x == 5);
}

test "while block" {
    var x: i32 = 0;
    while (x < 5) {
        x += 1;
    }
    try expect(x == 5);

    var i: u8 = 0;
    var sum: u8 = 0;

    i = 1;
    sum = 0;
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 55);

    i = 1;
    sum = 0;
    while (i < 10) : (i += 1) {
        if (i == 3) break;
        sum += i;
    }
    try expect(sum == 3);

    i = 1;
    sum = 0;
    while (i < 10) : (i += 1) {
        if (i % 2 == 0) continue;
        sum += i;
    }
    try expect(sum == 25);
}

test "for statement" {
    const str = [_]u8{ 'h', 'e', 'l', 'l', 'o' };

    for (str) |c| {
        try expect(c >= 'a' and c <= 'z');
    }

    for (str, 0..) |_, idx| {
        try expect(idx < 5);
    }
}

test "switch statement" {
    var x: i32 = 0;
    switch (5) {
        1 => x = 1,
        2 => x = 2,
        3 => x = 3,
        4 => x = 4,
        5 => x = 5,
        else => x = 6,
    }
    try expect(x == 5);

    switch (5) {
        1, 2, 3, 4 => x = 1,
        5 => x = 5,
        else => x = 6,
    }
    try expect(x == 5);

    switch (5) {
        1, 2, 3, 4 => x = 1,
        5, 6, 7 => x = 5,
        else => x = 6,
    }
    try expect(x == 5);

    switch (5) {
        1, 2, 3, 4 => x = 1,
        5, 6, 7 => x = 5,
        8, 9, 10 => x = 10,
        else => x = 6,
    }
    try expect(x == 5);

    switch (5) {
        1, 2, 3, 4 => x = 1,
        5, 6, 7 => x = 5,
        8, 9, 10 => x = 10,
        11 => x = 11,
        else => x = 6,
    }
    try expect(x == 5);

    switch (5) {
        1, 2, 3, 4 => x = 1,
        5, 6, 7 => x = 5,
        8, 9, 10 => x = 10,
        11 => x = 11,
        12 => x = 12,
        else => x = 6,
    }
    try expect(x == 5);
}

test "defer statement" {
    var x: f32 = 5;
    {

        // 同一のブロック内で複数のdeferがあった場合、逆順に処理をする。
        defer x += 2;
        defer x /= 2;

        // deferをつけた式は、ブロックを抜けるまで評価されない
        try expect(x == 5);
    }

    // ここでは(5 + 2) / 2 = 3.5 ではなく、
    // (5 / 2) + 2 = 4.5として評価される
    try expect(x == 4.5);
}

const FileOpenError = error{
    FileNotFound,
    PermissionDenied,
    OutOfMemory,
    Unknown,
};

const AllocationError = error{
    OutOfMemory,
};

test "coerce error from subset to superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
    try expect(@TypeOf(err) == FileOpenError);
}
