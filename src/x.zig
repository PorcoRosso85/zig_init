const std = @import("std");
const w = std.os.windows;

///**Opens a process**, giving you a handle to it.
///[MSDN](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-openprocess)
pub extern "kernel32" fn OpenProcess(
    ///[The desired process access rights](https://docs.microsoft.com/en-us/windows/win32/procthread/process-security-and-access-rights)
    dwDesiredAccess: w.DWORD,
    ///
    bInheritHandle: w.BOOL,
    dwProcessId: w.DWORD,
) callconv(w.WINAPI) ?w.HANDLE;

///spreadsheet position
pub const Pos = struct {
    ///row
    x: u32,
    ///column
    y: u32,
};

// const [6:0]u8
pub const message = "hello!";

//used to force analysis, as these things aren't otherwise referenced.
//特にこれらの識別子が他の場所で参照されていない場合に有用です。
// なぜなら、それらが参照されていない場合、コンパイラはそれらを解析する必要がないと判断し、それらの識別子に関連する可能なエラーや警告を見逃す可能性があるからです。
// このコードにより、それらの識別子が必ず解析され、それらに関連する問題が検出されることが保証されます。
comptime {
    _ = OpenProcess;
    _ = Pos;
    _ = message;
}

//Alternate method to force analysis of everything automatically, but only in a test build:
// std.testing.refAllDecls(@This());は、現在のスコープ（@This()によって参照される）内のすべての宣言を参照します。これにより、コンパイラはすべての宣言を解析し、それらに関連する可能なエラーや警告を検出します。
// このテストは、コードの全体的な健全性を確認するためのもので、特に大規模なプロジェクトで有用です。これにより、未使用の変数、未使用の関数、型の不一致など、さまざまな種類の問題を早期に検出できます。
test "Force analysis" {
    comptime {
        std.testing.refAllDecls(@This());
    }
}
