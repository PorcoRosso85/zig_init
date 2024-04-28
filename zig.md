# Zig は
汎用プログラミング言語およびツールチェインです. 
Zig 標準ライブラリは, 独自のドキュメントを持っています. 
Zig の標準ライブラリには, プログラムやライブラリを構築するためによく使われる アルゴリズムやデータ構造, 定義が含まれています. 

Zig のソースコードを格納したファイルは, UTF-8 でエンコードされたテキストファイルです. Zig のソースコードを格納したファイルは, 通常 .zig という拡張子で命名されます. 

Zig コードサンプル hello.zig に続いて, Zig ビルドシステムを使って hello.zig のソースコードから実行可能なプログラムをビルドします. 

このサンプルコードでは, まず @import 組み込み関数を使って Zig 標準ライブラリをビルドに追加しています. import("std") 関数呼び出しは, Zig 標準ライブラリを表す構造体を作成します. 次に, Zig Standard Library の機能にアクセスするための std という名前の定数識別子を宣言しています. 

次に, main という名前のパブリック関数, pub fn が宣言されています. main 関数は, Zig コンパイラにプログラムの先頭がどこに存在するかを伝えるために必要です. 実行されるように設計されたプログラムには, pub fn の main 関数が必要です. 
より高度なユースケースのために, Zig はプログラムの開始点がどこに存在するかをコンパイラに知らせるための他の機能を提供しています. また, ライブラリのコードは他のプログラムやライブラリから呼び出されるため, ライブラリには pub fn main 関数は必要ありません. 

関数とは, いくつかの文や式からなるブロックで, 全体として一つのタスクを実行するものです. 関数は, タスクの実行後にデータを返すこともあれば, 返さないこともあります. 関数がタスクを実行できない場合は, エラーを返すかもしれません. Zig はこれら全てを明示します. 

hello.zig のサンプルコードでは, main 関数が !void 戻り値型で宣言されています. この戻り値の型はエラーユニオン型と呼ばれるものです. この構文は, Zig コンパイラに, この関数はエラーか値を返すと伝えます. 
エラーユニオン型は, エラーセット型と他のデータ型（例えば, プリミティブ型や, 構造体, enum , ユニオンなどのユーザー定義型）を組み合わせたものである. エラーユニオン型の完全な形式は, <エラーセット型>!<任意のデータ型>です. コードサンプルでは, エラーセットタイプは ! 演算子の左側に明示的に書かれていません. このように書かれた場合, エラーセット型は推論されたエラーセット型となります. 演算子 ! の後の void は, 通常の場合(すなわち, エラーが発生しない場合)にはその関数が値を返さないことをコンパイラに伝えます. 

経験豊富なプログラマーへの注意 Zig にはブーリアン演算子 !a もあります. ここで a は bool 型の値です. エラーユニオン型は, 構文上, 型の名前を含んでいます. 

まず, 標準出力の書き手を表す定数識別子 stdout が初期化される. そして, Hello, world! のメッセージを標準出力に出力しようとする. 

stdout.print() 関数に渡された 2 つの引数, "hello, {s}!\n" と .{"world"} は, コンパイル時に評価されます. このコードサンプルは, print 関数内で文字列代入を行う方法を示すために意図的に書かれたものです. 第 1 引数の中括弧は, 第 2 引数のコンパイル時に既知の値(匿名構造体リテラル)に置換されます. 第 1 引数の二重引用符の内側の \n は, 改行文字用のエスケープシーケンスです. try 式は, stdout.print の結果を評価します. 結果がエラーの場合, try 式はエラーとともに main から戻ってきます. そうでなければ, プログラムは続行されます. この場合, main 関数の中で実行できる文や式はもう残っていないので, プログラムは終了します. 

Zig では, 標準出力ライターの print 関数は, 実際には汎用ライターの一部として定義された関数であるため, 失敗が許される. ファイルへのデータ書き込みを表す汎用ライタを考えてみよう. ディスクが満杯になると, ファイルへの書き込みは失敗します. しかし, 標準出力へのテキスト書き込みが失敗することは通常想定されません. 標準出力への出力が失敗した場合の処理を回避するために, 代替の関数を使用することができます：適切なロギングを行うための std.log の関数または std.debug.print 関数です. このドキュメントでは, 後者のオプションを使用して, 標準エラー出力(stderr)に印刷し, 失敗した場合は静かにリターンすることにします. 次のコードサンプルhello_again.zig は std.debug.print を使用した例です. 
なお, std.debug.print は失敗できないので, 戻り値の型から ! を抜いても良い. 

Zig には複数行のコメント（例えば, C 言語の /* */ コメントのようなもの）はありません. このため, Zig はコードの各行を文脈に関係なくトークン化できるという特性を持つようになりました. 

### プリミティブ型
文字列リテラルと Unicode コードポイントリテラル
文字列リテラルは, ヌル終端バイト配列への定数型単一項目ポインタです. 文字列リテラルの型は, 長さとヌル終端であるという事実の両方をコード化しているため, スライスとヌル終端ポインタの両方に強制することが可能です. 文字列リテラルを再参照すると, 配列に変換されます. 

Zig における文字列のエンコーディングは, 事実上 UTF-8 であると仮定されています. Zig のソースコードは UTF-8 でエンコードされているので, ソースコードの文字列リテラル内に現れる非 ASCII バイトは, その UTF-8 の意味を Zig のプログラム内の文字列の内容に引き継ぎ, コンパイラがそのバイトを修正することはありません. ただし, UTF-8 以外のバイトを文字列リテラルに埋め込むことは, \xNN 表記で可能です. 

Unicode コードポイント・リテラルのタイプは comptime_int で, 整数リテラルと同じです. すべての Escape Sequence は, 文字列リテラルと Unicode コードポイント・リテラルの両方において有効です. 

他の多くのプログラミング言語では, Unicode コードポイント リテラルを「文字リテラル」と呼びます. しかし, Unicode 仕様の最近のバージョン（Unicode 13.0 時点）では, 「文字」の正確な技術的定義は存在しません. Zig では, Unicode コードポイントリテラルは, Unicode のコードポイントの定義に対応します. 

### エスケープシーケンス
なお, 有効な Unicode ポイントの最大値は 0x10ffff です. 

複数行にまたがる文字列リテラル
複数行の文字列リテラルにはエスケープ記号がなく, 複数行にまたがることができます. 複数行の文字列リテラルを開始するには,  \\ トークンを使用します. コメントと同じように, 文字列リテラルは行末まで続きます. 行の終わりは文字列リテラルに含まれません. ただし, 次の行が \\ で始まる場合は, 改行が追加され, 文字列リテラルが続行されます. 

もし, 変更可能な変数が必要な場合は, var キーワードを使用します. 
変数は初期化する必要があります. 
変数の初期化を行わない場合は, undefined を使用します. 
undefined は任意の型に強制することができます. これが起こると, 値が undefined であることを検出することができなくなる. undefined は, 値が何にでもなり得るということであり, 型によれば無意味なものでさえもなり得るということである. 英語に訳すと, undefined は「意味のない値だ. この値を使うとバグになる. この値は使われないか, 使われる前に上書きされるでしょう. 」 という意味です. 

デバッグモードでは, Zig は 0xaa バイトを未定義メモリに書き込む. これは, バグを早期に発見し, デバッガで未定義メモリの使用を検出しやすくするためです. ただし, この動作はあくまで実装上のものであり, 言語のセマンティクスではないので, コード上で観測可能であることは保証されていません. 

## Zig Test
1 つまたは複数のテスト宣言の中で書かれたコードを使用して, 動作が期待に沿うことを確認することができます. 
このドキュメントでは, Zig 標準ライブラリで提供されているデフォルトのテストランナーの機能について説明します. そのソースコードは lib/test_runner.zig にあります. 

上のシェル出力は, zig test コマンドの後に 2 行を表示しています. これらの行は, デフォルトのテストランナーによって標準エラーに出力されます. 
このような行は, テストの総数のうち, どのテストが実行されているかを示しています. この場合, [1/1] は 1 つのテストのうち, 最初のテストが実行されていることを示しています. テストランナープログラムの標準エラーがターミナルに出力される場合, テストが成功するとこれらの行はクリアされることに注意してください. 

Test Declarations
テスト宣言は, キーワード test, 文字列リテラルで記述されたオプションの名前,  関数内で許可された有効な Zig コードを含むブロックの順で記述します. 

慣習として, 名前のないテストは他のテストを実行させるためにのみ使用されるべきです. 名前のないテストにフィルタをかけることはできません. 

テストの宣言は Functions と似ています. テストの暗黙の戻り値は anyerror!void というエラーユニオン型であり, これを変更することはできません. Zig ソースファイルが zig テストツールを使ってビルドされない場合, テスト宣言はビルドから省かれます. 

テスト宣言は, テスト対象のコードが書かれているのと同じファイルに書くこともできますし, 別の Zig ソースファイルに書くこともできます. テスト宣言はトップレベルの宣言であるため, 順序に関係なく, テスト対象のコードの前でも後でも書くことができます. 

こちらもご覧ください. 

ネストされたコンテナ・テスト
zig テストツールがテストランナーをビルドするとき, 解決された test 宣言だけがビルドに含まれます. 初期状態では, 与えられた Zig ソースファイルのトップレベルの宣言だけが解決されます. ネストしたコンテナがトップレベルのテスト宣言から参照されていない限り, ネストしたコンテナのテストは解決されません. 

以下のコード サンプルでは, std.testing.refAllDecls(@This()) 関数呼び出しを使用して, インポートした Zig ソース ファイルを含むファイル内のすべてのコンテナを参照し ています. このコードサンプルでは, _ = C; 構文を使用してコンテナを参照する別の方法も示しています. この構文は, コンパイラに代入演算子の右辺にある式の結果を無視するように指示します. 

// 構造体を宣言する. 
// Zigはフィールドの順序と構造体のサイズについては保証しないが, 
// フィールドはABIアラインされていることが保証される. 

// OpenGLに渡したいから, 
// バイトの並び方にこだわりたいのかもしれません. 

// 構造体のインスタンスを宣言する. 
// もしかしたら, まだ記入できていない項目があるかもしれません. 

// 構造体はメソッドを持つことができる
// 構造体のメソッドは特別なものではなく, 
// ドット構文で呼び出すことができる名前空間関数に過ぎない. 

    // ドット構文で呼び出せるということ以外, 
    // 構造体メソッドは特別なものではありません. 
    // 構造体内の他の宣言と同様に参照することができます. 

// 構造体は宣言を持つことができる. 
// 構造体は0個のフィールドを持つことができる. 

    // 空の構造体をインスタンス化することは可能です. 

// 構造体フィールドの順序は, 最適なパフォーマンスを得るためにコンパイラが決定します. 
// しかし, フィールドポインタがあれば, 構造体のベースポインタを計算することができます. 

// 関数から構造体を返すことができる. 
// これがZigでのジェネリックのやり方です. 

    // コンパイル時に呼び出される関数は, メモ化されます. 
    // つまり, こんなことができるのです. 

    // 型は第一級の値なので, 
    // 変数に代入することで型をインスタンス化することができます. 

    // 構造体へのポインタを使用する場合, 明示的にポインタを再参照することなく, 
    // フィールドに直接アクセスすることができます. 
    // つまり, 次のようなことができます. 

各構造体フィールドは, フィールドのデフォルト値を示す式を持つことができる. このような式は計算時に実行され, 構造体リテラル式でフィールドを省略することができる. 

### extern struct
extern 構造体は, ターゲットの C ABI にマッチするようにメモリ内のレイアウトが保証されています. 

この種の構造体は, C の ABI との互換性のためにのみ使用されるべきです. それ以外の用途では, packed struct か normal struct を使用してください. 

こちらも参照してください. 
通常の構造体とは異なり, packed struct はメモリ内のレイアウトが保証されています. 

フィールドは宣言された順番に, 小さいものから大きいものへと並びます. 
また, フィールド間のパディングはありません. 
Zig は任意の幅の整数をサポートしており, 通常, 8 ビット未満の整数は 1 バイトのメモリを使用しますが, パックド構造体では, そのビット幅をそのまま使用します.  bool フィールドはちょうど 1 ビットを使用します. 
enum フィールドは, その整数タグ型のビット幅をそのまま使用します. 
packed union フィールドは, 最大のビット幅を持つ union フィールドのビット幅を正確に使用します. 
非 ABI アライメントフィールドは, ターゲットエンディアンに従って, ABI アライメント可能な最小の整数にパックされます. 
つまり, パックされた構造体は, @bitCast や @ptrCast に参加して, メモリを再解釈することができるのです. これはコンパイル時にさえも機能します. 

Zig では, 非バイトアラインのフィールドのアドレスを取ることができます. 
しかし, 非バイトアラインのフィールドへのポインタは特殊な性質を持っており, 通常のポインタを期待する場合には渡すことができない. 

この場合, 非 ABI アラインメントフィールドへのポインタはビットオフセットに言及していますが, 関数は ABI アラインメントポインタを想定しているので, 関数 bar を呼び出すことはできません. 

ABI アライメントされていないフィールドへのポインタは, そのホスト整数内の他のフィールドと同じアドレスを共有します. 
これは, @bitOffsetOf と @offsetOf で観察することができます. 

パックド構造体は, その背後の整数と同じアラインメントを持ちますが, パックド構造体へのオーバーアラインメントのポインタは, これを上書きすることができます. 
また, 構造体フィールドのアライメントを設定することも可能です. 

Packed 構造体を volatile で使用することは問題があり, 将来的にはコンパイルエラーになる可能性があります. この問題の詳細については, このイシューを参照してください. 

### Struct Naming
構造体はすべて匿名なので, Zig はいくつかのルールに基づいて型名を推論します. 

構造体が変数の初期化式に含まれる場合は, その変数の名前が付けられます. 
構造体が return 式の中にある場合, 構造体の名前は戻り値の関数にちなんで付けられます（パラメータの値はシリアライズされます）. 
それ以外の場合は, (anonymous struct at file.zig:7:38) のような名前になります. 
構造体が他の構造体の内部で宣言されている場合は, 親構造体の名前と, 前の規則で推定された名前の両方がドットで区切られて付けられます. 

Zig では, リテラルの構造体型を省略することができます. 結果が強制される場合, 構造体リテラルはコピーなしで結果の場所を直接インスタンス化します. 
構造体の型を推論することができます. ここでは, 結果の場所に型が含まれていないため, Zig が型を推論します. 

匿名構造体は, フィールド名を指定せずに作成することができ, 「タプル」と呼ばれます. 

フィールドは暗黙のうちに 0 から始まる数値で命名されます. フィールド名は整数であるため, アクセスには@"0 "構文を使用しなければなりません. また, @""内の名前は常に識別子として認識されます. 

配列と同様に, タプルは.len フィールドを持ち, インデックスを作成することができ, ++と**演算子で操作することができます. また, インライン for で反復処理も可能です. 

// 特定のenumフィールドを宣言する. 
// enumの序数にアクセスしたい場合は, タグの種類を指定することができます. 
// これで, u2とValueの間でキャスティングができるようになりました. 
// 序数は0から始まり, 前のメンバーから1ずつカウントアップしていきます. 

// enumの序数をオーバーライドすることができます. 

// また, 一部の値のみをオーバーライドすることも可能です. 

// 構造体や共用体と同じように, 列挙型はメソッドを持つことができます. 
// Enum のメソッドは特別なものではありません. 
// 関数であり, ドットシンタックスで呼び出すことができます. 

// enum は切り替えが可能である. 

// @typeInfo を使用すると，enum の整数タグ型にアクセスすることができる. 

// @typeInfoは, フィールド数とフィールド名を教えてくれます. 

// @tagName は enum の値を [:0]const u8 で表現したものである:

外部 enum
デフォルトでは, 列挙型は C ABI との互換性が保証されていません. 

C-ABI 互換の enum の場合, enum に明示的なタグ型を提供する. 

Enum リテラル
enum リテラルは, enum 型を指定せずに enum フィールドの名前を指定することができます. 

非網羅的な enum
非網羅的な列挙は, 末尾に'_'フィールドを追加することによって作成することができる. タグタイプを指定する必要があり, すべての列挙値を消費することはできません. 

非網羅的な列挙型の @intToEnum は整数タグ型への @intCast の安全なセマンティクスを含みますが, それ以上になると常に明確に定義された列挙型の値になります. 

非網羅的な列挙型のスイッチは, else プロングの代わりに '_' プロングを含めることができますが, 既知のタグ名がすべてスイッチによって処理されないとコンパイルエラーになるという違いがあります. 

const std = @import("std");
const expect = std.testing.expect;

const Number = enum(u8) {
    one,
    two,
    three,
    _,
};

test "switch on non-exhaustive enum" {
    const number = Number.one;
    const result = switch (number) {
        .one => true,
        .two,
        .three => false,
        _ => false,
    };
    try expect(result);
    const is_one = switch (number) {
        .one => true,
        else => false,
    };
    try expect(is_one);
}
$ zig test test_switch_non-exhaustive.zig
1/1 test.switch on non-exhaustive enum... OK
All 1 tests passed.
union
ベアユニオンは, ある値が取り得る型の集合を, フィールドのリストとして定義する. 一度にアクティブにできるフィールドは 1 つだけである. ベアユニオンのメモリ内表現は保証されない. ベアユニオンはメモリの再解釈に使用できない. その場合は, @ptrCast を使用するか, メモリ内レイアウトが保証されている extern union または packed union を使用する. 非アクティブフィールドへのアクセスは安全が確認された未定義動作である. 

const Payload = union {
    int: i64,
    float: f64,
    boolean: bool,
};
test "simple union" {
    var payload = Payload{ .int = 1234 };
    payload.float = 12.34;
}
$ zig test test_wrong_union_access.zig
1/1 test.simple union... thread 523285 panic: access of union field 'float' while field 'int' is active
/home/ci/actions-runner/_work/zig-bootstrap/zig/docgen_tmp/test_wrong_union_access.zig:8:12: 0x20bdb2 in test.simple union (test)
    payload.float = 12.34;
           ^
/home/ci/actions-runner/_work/zig-bootstrap/out/host/lib/zig/test_runner.zig:66:28: 0x20d953 in main (test)
        } else test_fn.func();
                           ^
/home/ci/actions-runner/_work/zig-bootstrap/out/host/lib/zig/std/start.zig:606:22: 0x20c7c0 in posixCallMainAndExit (test)
            root.main();
                     ^
/home/ci/actions-runner/_work/zig-bootstrap/out/host/lib/zig/std/start.zig:376:5: 0x20c271 in _start (test)
    @call(.never_inline, posixCallMainAndExit, .{});
    ^
error: the following test command crashed:
/home/ci/actions-runner/_work/zig-bootstrap/out/zig-local-cache/o/1c116cd81b33d09a357633f91ca2864b/test
ユニオン全体を割り当てることで, 別のフィールドをアクティブにすることができます. 

const std = @import("std");
const expect = std.testing.expect;

const Payload = union {
    int: i64,
    float: f64,
    boolean: bool,
};
test "simple union" {
    var payload = Payload{ .int = 1234 };
    try expect(payload.int == 1234);
    payload = Payload{ .float = 12.34 };
    try expect(payload.float == 12.34);
}
$ zig test test_simple_union.zig
1/1 test.simple union... OK
All 1 tests passed.
switch をユニオンで使用するには, タグ付きユニオンである必要があります. 

タグが既知の名前のときにユニオンを初期化するには, @unionInit を参照する. 

Tagged union
ユニオンは列挙型（enum）のタグ型で宣言することができます. これにより, ユニオンはタグ付きユニオンとなり, スイッチ式と一緒に使用することができるようになります. タグ付きユニオンは, そのタグ型に強制的に型変換されます. このタイプの強制変換は, ユニオンと列挙型の型の互換性を確保します. 

const std = @import("std");
const expect = std.testing.expect;

const ComplexTypeTag = enum {
    ok,
    not_ok,
};
const ComplexType = union(ComplexTypeTag) {
    ok: u8,
    not_ok: void,
};

test "switch on tagged union" {
    const c = ComplexType{ .ok = 42 };
    try expect(@as(ComplexTypeTag, c) == ComplexTypeTag.ok);

    switch (c) {
        ComplexTypeTag.ok => |value| try expect(value == 42),
        ComplexTypeTag.not_ok => unreachable,
    }
}

test "get tag type" {
    try expect(std.meta.Tag(ComplexType) == ComplexTypeTag);
}
$ zig test test_tagged_union.zig
1/2 test.switch on tagged union... OK
2/2 test.get tag type... OK
All 2 tests passed.
スイッチ式内でタグ付きユニオンのペイロードを変更するためには, 変数名の前に*を置いてポインタにする必要があります. 

const std = @import("std");
const expect = std.testing.expect;

const ComplexTypeTag = enum {
    ok,
    not_ok,
};
const ComplexType = union(ComplexTypeTag) {
    ok: u8,
    not_ok: void,
};

test "modify tagged union in switch" {
    var c = ComplexType{ .ok = 42 };

    switch (c) {
        ComplexTypeTag.ok => |*value| value.* += 1,
        ComplexTypeTag.not_ok => unreachable,
    }

    try expect(c.ok == 43);
}
$ zig test test_switch_modify_tagged_union.zig
1/1 test.modify tagged union in switch... OK
All 1 tests passed.
ユニオンは列挙体（enum）のタグタイプを推論するために使用することができます. さらに, ユニオンは構造体（struct）や列挙体と同様にメソッドを持つことができます. 

const std = @import("std");
const expect = std.testing.expect;

const Variant = union(enum) {
    int: i32,
    boolean: bool,

    // void can be omitted when inferring enum tag type.
    none,

    fn truthy(self: Variant) bool {
        return switch (self) {
            Variant.int => |x_int| x_int != 0,
            Variant.boolean => |x_bool| x_bool,
            Variant.none => false,
        };
    }
};

test "union method" {
    var v1 = Variant{ .int = 1 };
    var v2 = Variant{ .boolean = false };

    try expect(v1.truthy());
    try expect(!v2.truthy());
}
$ zig test test_union_method.zig
1/1 test.union method... OK
All 1 tests passed.
@tagName を使用すると, フィールド名を表すコンパイル時（comptime）[:0]const u8 の値を返すことができます. 

const std = @import("std");
const expect = std.testing.expect;

const Small2 = union(enum) {
    a: i32,
    b: bool,
    c: u8,
};
test "@tagName" {
    try expect(std.mem.eql(u8, @tagName(Small2.a), "a"));
}
$ zig test test_tagName.zig
1/1 test.@tagName... OK
All 1 tests passed.
extern union
外部ユニオン（extern union）は, ターゲットの C ABI と互換性のあるメモリレイアウトが保証されています. 

詳しくは以下を参照してください:

extern struct
packed union
パックされたユニオン（packed union）は, 明確に定義されたメモリレイアウトを持ち, パックされた構造体に含めることができます. 

Anonymous Union Literals
匿名の構造体リテラルの構文は, タイプを指定せずにユニオンを初期化するために使用することができます. 

const std = @import("std");
const expect = std.testing.expect;

const Number = union {
    int: i32,
    float: f64,
};

test "anonymous union literal syntax" {
    var i: Number = .{.int = 42};
    var f = makeNumber();
    try expect(i.int == 42);
    try expect(f.float == 12.34);
}

fn makeNumber() Number {
    return .{.float = 12.34};
}
$ zig test test_anonymous_union.zig
1/1 test.anonymous union literal syntax... OK
All 1 tests passed.
opaque
opaque {} は新たな型を宣言しますが, そのサイズやアライメントは未知（ただし非ゼロ）です. これには, structs, unions, および enums と同様の宣言が含まれます. 

これは, 構造体の詳細を公開しない C コードとやり取りする際に, 型の安全性を保つために一般的に使用されます. 例：

const Derp = opaque {};
const Wat = opaque {};

extern fn bar(d: *Derp) void;
fn foo(w: *Wat) callconv(.C) void {
    bar(w);
}

test "call foo" {
    foo(undefined);
}
$ zig test test_opaque.zig
docgen_tmp/test_opaque.zig:6:9: error: expected type '*test_opaque.Derp', found '*test_opaque.Wat'
    bar(w);
        ^
docgen_tmp/test_opaque.zig:6:9: note: pointer type child 'test_opaque.Wat' cannot cast into pointer type child 'test_opaque.Derp'
docgen_tmp/test_opaque.zig:2:13: note: opaque declared here
const Wat = opaque {};
            ^~~~~~~~~
docgen_tmp/test_opaque.zig:1:14: note: opaque declared here
const Derp = opaque {};
             ^~~~~~~~~
docgen_tmp/test_opaque.zig:4:18: note: parameter type declared here
extern fn bar(d: *Derp) void;
                 ^~~~~
referenced by:
    test.call foo: docgen_tmp/test_opaque.zig:10:5
    remaining reference traces hidden; use '-freference-trace' to see all reference traces
Blocks
Shadowing
Empty Blocks
switch
Exhaustive Switching
Switching with Enum Literals
Inline switch
while
Labeled while
while with Optionals
while with Error Unions
inline while
for
Labeled for
inline for
if
defer
unreachable
Basics
At Compile-Time
noreturn
Functions
Pass-by-value Parameters
Function Parameter Type Inference
Function Reflection
Errors
Error Set Type
The Global Error Set
Error Union Type
catch
try
errdefer
Common errdefer Slip-Ups
Merging Error Sets
Inferred Error Sets
Error Return Traces
Implementation Details
Optionals
Optional Type
null
Optional Pointers
Casting
Type Coercion
Type Coercion: Stricter Qualification
Type Coercion: Integer and Float Widening
Type Coercion: Coercion Float to Int
Type Coercion: Slices, Arrays and Pointers
Type Coercion: Optionals
Type Coercion: Error Unions
Type Coercion: Compile-Time Known Numbers
Type Coercion: unions and enums
Type Coercion: undefined
Explicit Casts
Peer Type Resolution
Zero Bit Types
void
Result Location Semantics
usingnamespace
comptime
Zig では, コンパイル時に式が既知かどうかという概念を重要視しています. この概念が使われる場所はいくつかあり, これらのビルディングブロックは, 言語を小さく, 読みやすく, 強力に保つために使われます. 

Introducing the Compile-Time Concept
Compile-Time Parameters
コンパイル時のパラメータは, Zig がジェネリックスを実装する方法です. これはコンパイル時のダックタイピングです. 

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}
fn gimmeTheBiggerFloat(a: f32, b: f32) f32 {
    return max(f32, a, b);
}
fn gimmeTheBiggerInteger(a: u64, b: u64) u64 {
    return max(u64, a, b);
}
Zig では, 型は一級市民です. 変数に代入したり, 関数にパラメータとして渡したり, 関数から返したりすることができます. しかし, コンパイル時に分かっている式にしか使えないので, 上のスニペットのパラメータ T は comptime とマークされていなければなりません. 

comptime パラメータとは, 次のような意味です. 

コールサイトでは, 値はコンパイル時に分かっていなければならず, そうでなければコンパイルエラーとなる. 
関数定義では, 値はコンパイル時に既知である. 
例えば, 上記のスニペットに別の関数を導入するとします. 

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}
test "try to pass a runtime type" {
    foo(false);
}
fn foo(condition: bool) void {
    const result = max(
        if (condition) f32 else u64,
        1234,
        5678);
    _ = result;
}
$ zig test test.zig
docgen_tmp/test.zig:9:13: error: unable to resolve comptime value
        if (condition) f32 else u64,
            ^~~~~~~~~
docgen_tmp/test.zig:9:13: note: condition in comptime branch must be comptime-known
referenced by:
    test.try to pass a runtime type: docgen_tmp/test.zig:5:5
    remaining reference traces hidden; use '-freference-trace' to see all reference traces
これは, プログラマが, コンパイル時に分かっている値を期待する関数に, 実行時にしか分からない値を渡そうとしたため, エラーとなります. 

もう一つのエラーになる方法は, 関数が解析されるときに型チェッカに違反するような型を渡した場合です. これが, コンパイル時ダックタイピングの意味である. 

例えば:

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}
test "try to compare bools" {
    _ = max(bool, true, false);
}
$ zig test test.zig
docgen_tmp/test.zig:2:18: error: operator > not allowed for type 'bool'
    return if (a > b) a else b;
               ~~^~~
referenced by:
    test.try to compare bools: docgen_tmp/test.zig:5:9
    remaining reference traces hidden; use '-freference-trace' to see all reference traces
一方, comptime パラメータを持つ関数定義の内部では, コンパイル時に値が判明しています. つまり, その気になれば, bool 型でもこの機能を実現できるのだ. 

fn max(comptime T: type, a: T, b: T) T {
    if (T == bool) {
        return a or b;
    } else if (a > b) {
        return a;
    } else {
        return b;
    }
}
test "try to compare bools" {
    try @import("std").testing.expect(max(bool, false, true) == true);
}
$ zig test comptime_max_with_bool.zig
1/1 test.try to compare bools... OK
All 1 tests passed.
これは, Zig がコンパイル時に条件が分かっている場合は if 式を暗黙のうちにインライン化し, コンパイラが実行されなかった分岐の解析をスキップすることを保証しているためです. 

つまり, この状況で max に対して生成される実際の関数は次のようになる. 

fn max(a: bool, b: bool) bool {
    return a or b;
}
コンパイル時に既知の値を扱うコードはすべて削除され, タスクを達成するために必要な実行時コードだけが残されます. 

これは switch 式についても同様で, 対象となる式がコンパイル時に既知であれば, 暗黙のうちにインライン化されます. 

コンパイル時変数 (Compile-Time Variables)
Zig では, プログラマは変数に comptime というラベルを付けることができます. これにより, コンパイラに対して, その変数のロードとストアがすべてコンパイル時に実行されることが保証される. これに違反すると, コンパイルエラーになる. 

このことと, ループを inline できることを組み合わせると, コンパイル時に部分的に評価され, 実行時に部分的に評価されるような関数を書くことができるようになります. 

例えば:

const expect = @import("std").testing.expect;

const CmdFn = struct {
    name: []const u8,
    func: fn(i32) i32,
};

const cmd_fns = [_]CmdFn{
    CmdFn {.name = "one", .func = one},
    CmdFn {.name = "two", .func = two},
    CmdFn {.name = "three", .func = three},
};
fn one(value: i32) i32 { return value + 1; }
fn two(value: i32) i32 { return value + 2; }
fn three(value: i32) i32 { return value + 3; }

fn performFn(comptime prefix_char: u8, start_value: i32) i32 {
    var result: i32 = start_value;
    comptime var i = 0;
    inline while (i < cmd_fns.len) : (i += 1) {
        if (cmd_fns[i].name[0] == prefix_char) {
            result = cmd_fns[i].func(result);
        }
    }
    return result;
}

test "perform fn" {
    try expect(performFn('t', 1) == 6);
    try expect(performFn('o', 0) == 1);
    try expect(performFn('w', 99) == 99);
}
$ zig test comptime_vars.zig
1/1 test.perform fn... OK
All 1 tests passed.
この例は少し不自然です. なぜなら, コンパイル時の評価要素は不要であり, このコードはすべてランタイムで行われれば問題なく動作するからです. しかし, 結局は異なるコードを生成しています. この例では, 関数 performFn は, 与えられた prefix_char の異なる値に対して, 3 回生成されます. 

// From the line:
// expect(performFn('t', 1) == 6);
fn performFn(start_value: i32) i32 {
    var result: i32 = start_value;
    result = two(result);
    result = three(result);
    return result;
}
// From the line:
// expect(performFn('o', 0) == 1);
fn performFn(start_value: i32) i32 {
    var result: i32 = start_value;
    result = one(result);
    return result;
}
// From the line:
// expect(performFn('w', 99) == 99);
fn performFn(start_value: i32) i32 {
    var result: i32 = start_value;
    return result;
}
これはデバッグビルドでも起こることです. リリースビルドでは, これらの生成された関数はまだ厳密な LLVM 最適化を通過していることに注意してください. しかし, 重要なことは, これはより最適化されたコードを書くための方法ではなく, コンパイル時に起こるべきことがコンパイル時に起こることを確認する方法であることです. これにより, より多くのエラーを検出することができ, 後述するように, 他の言語ではマクロや生成コード, プリプロセッサを使用しなければ実現できないような表現が可能になる. 

コンパイル時の式 (Compile-Time Expressions)
Zig では, 与えられた式がコンパイル時と実行時のどちらで知られているかが重要である. プログラマはコンパイル時に評価されることを保証するためにコンパイル時 式を使用することができる. もし, それができない場合は, コンパイラがエラーを出す. たとえば:

extern fn exit() noreturn;

test "foo" {
    comptime {
        exit();
    }
}
$ zig test test.zig
docgen_tmp/test.zig:5:13: error: comptime call of extern function
        exit();
        ~~~~^~
Generic Data Structures
Case Study: print in Zig
Assembly
Output Constraints
Input Constraints
Clobbers
Global Assembly
Atomics
Async Functions
Suspend and Resume
Resuming from Suspend Blocks
Async and Await
Async Function Example
Builtin Functions
組み込み関数は, コンパイラが提供するもので, @が先頭に付きます. パラメータの comptime キーワードは, そのパラメータがコンパイル時に既知でなければならないことを意味します. 

@addrSpaceCast
addrSpaceCast(comptime addrspace: std.builtin.AddressSpace, ptr: anytype) anytype.
ポインタをあるアドレス空間から別のアドレス空間に変換します. 現在のターゲットとアドレス空間に応じて, このキャストはノーオープン, 複雑な操作, または違法となる可能性があります. キャストが正当である場合, 結果のポインタはポインタ・オペランドと同じメモリ位置を指します. 同じアドレス空間間でポインタをキャストすることは, 常に有効です. 

@addWithOverflow
@addWithOverflow(a: anytype, b: anytype) struct { @TypeOf(a, b), u1 }
「a + b」を実行し, 結果と可能なオーバーフロービットを含むタプルを返します. 

@alignCast
@alignCast(comptime alignment: u29, ptr: anytype) anytype
ptr は *T ,  ?*T , または []T のいずれかの型です. この関数は,  ptr と同じ型を返しますが, アライメントが新しい値に調整されたものです. 

生成されたコードには, ポインタが約束どおりにアライメントされていることを確認するためのポインタアライメントの安全性チェックが追加されます. 

@alignOf
@alignOf(comptime T: type) comptime_int
この関数は, 現在のターゲットが C ABI にマッチするように, この型がアライメントされるべきバイト数を返します. ポインタの子型がこのアラインメントを持っている場合, アラインメントを省略することができます. 

const assert = @import("std").debug.assert;
comptime {
    assert(*u32 == *align(@alignOf(u32)) u32);
}
結果は, ターゲット固有のコンパイル時定数です. これは, @sizeOf(T)以下であることが保証されています. 

参照:

Alignment

@as
@asyncCall
@atomicLoad
@atomicRmw
@atomicStore
@bitCast
@bitOffsetOf
@boolToInt
@bitSizeOf
@breakpoint
@mulAdd
@byteSwap
@bitReverse
@offsetOf
@call
@cDefine
@cImport
@cInclude
@clz
@cmpxchgStrong
@cmpxchgWeak
@compileError
@compileLog
@ctz
@cUndef
@divExact
@divFloor
@divTrunc
@embedFile
@enumToInt
@errorName
@errorReturnTrace
@errorToInt
@errSetCast
@export
@extern
@fence
@field
@fieldParentPtr
@floatCast
@floatToInt
@frame
@Frame
@frameAddress
@frameSize
@hasDecl
@hasField
@import
@intCast
@intToEnum
@intToError
@intToFloat
@intToPtr
@max
@memcpy
@memset
@min
@wasmMemorySize
@wasmMemoryGrow
@mod
@mulWithOverflow
@panic
@popCount
@prefetch
@ptrCast
@ptrToInt
@rem
@returnAddress
@select
@setAlignStack
@setCold
@setEvalBranchQuota
@setFloatMode
@setRuntimeSafety
@shlExact
@shlWithOverflow
@shrExact
@shuffle
@sizeOf
@splat
@reduce
@src
@sqrt
@sin
@cos
@tan
@exp
@exp2
@log
@log2
@log10
@fabs
@floor
@ceil
@trunc
@round
@subWithOverflow
@tagName
@This
@truncate
@Type
@typeInfo
@typeName
@TypeOf
@unionInit
@Vector
Build Mode
Debug
ReleaseFast
ReleaseSafe
ReleaseSmall
Single Threaded Builds
未定義の動作
Zig には未定義の動作が数多く存在します. 未定義の動作がコンパイル時に検出された場合, Zig はコンパイル・エラーを 出して処理を続行させません. コンパイル時に検出できない未定義の動作のほとんどは, 実行時に検出できま す. このような場合, Zig は安全性チェックを行います. 安全性チェックは @setRuntimeSafety でブロック単位で無効にできます. ReleaseFast と ReleaseSmall ビルドモードでは, 最適化を促進するために, すべての安全性チェックを無効にします（@setRuntimeSafety で上書きされる場合を除く）. 

安全性チェックに失敗すると, Zig は以下のようなスタックトレースを残してクラッシュする. 

test "safety check" {
    unreachable;
}
$ zig test test.zig
1/1 test.safety check... thread 1639714 panic: reached unreachable code
docgen_tmp/test.zig:2:5: 0x211565 in test.safety check (test)
    unreachable;
    ^
/home/andy/tmp/zig/lib/test_runner.zig:63:28: 0x212b68 in main (test)
        } else test_fn.func();
                           ^
/home/andy/tmp/zig/lib/std/start.zig:596:22: 0x211e4b in posixCallMainAndExit (test)
            root.main();
                     ^
/home/andy/tmp/zig/lib/std/start.zig:368:5: 0x211911 in _start (test)
    @call(.{ .modifier = .never_inline }, posixCallMainAndExit, .{});
    ^
error: the following test command crashed:
/home/andy/tmp/zig/zig-cache/o/c8cfbb273b267e28462c38d7de2721ed/test
到達不可能なコードに到達する
コンパイル時:

comptime {
    assert(false);
}
fn assert(ok: bool) void {
    if (!ok) unreachable; // assertion failure
}
$ zig test test.zig
docgen_tmp/test.zig:5:14: error: reached unreachable code
    if (!ok) unreachable; // assertion failure
             ^~~~~~~~~~~
docgen_tmp/test.zig:2:11: note: called from here
    assert(false);
    ~~~~~~^~~~~~~
ランタイム時:

const std = @import("std");

pub fn main() void {
    std.debug.assert(false);
}
$ zig build-exe test.zig

$ ./test
thread 1639774 panic: reached unreachable code
/home/andy/tmp/zig/lib/std/debug.zig:278:14: 0x211720 in assert (test)
    if (!ok) unreachable; // assertion failure
             ^
docgen_tmp/test.zig:4:21: 0x20fffa in main (test)
    std.debug.assert(false);
                    ^
/home/andy/tmp/zig/lib/std/start.zig:596:22: 0x20f6bb in posixCallMainAndExit (test)
            root.main();
                     ^
/home/andy/tmp/zig/lib/std/start.zig:368:5: 0x20f181 in _start (test)
    @call(.{ .modifier = .never_inline }, posixCallMainAndExit, .{});
    ^
(process terminated by signal)
インデックス・アウト・オブ・バウンズ
コンパイル時:

comptime {
    const array: [5]u8 = "hello".*;
    const garbage = array[5];
    _ = garbage;
}
$ zig test test.zig
docgen_tmp/test.zig:3:27: error: index 5 outside array of length 5
    const garbage = array[5];
                          ^
ランタイム時:

pub fn main() void {
    var x = foo("hello");
    _ = x;
}

fn foo(x: []const u8) u8 {
    return x[5];
}
$ zig build-exe test.zig

$ ./test
thread 1639834 panic: index out of bounds: index 5, len 5
docgen_tmp/test.zig:7:5: 0x2119b9 in foo (test)
    return x[5];
    ^
docgen_tmp/test.zig:2:16: 0x21000b in main (test)
    var x = foo("hello");
               ^
/home/andy/tmp/zig/lib/std/start.zig:596:22: 0x20f6bb in posixCallMainAndExit (test)
            root.main();
                     ^
/home/andy/tmp/zig/lib/std/start.zig:368:5: 0x20f181 in _start (test)
    @call(.{ .modifier = .never_inline }, posixCallMainAndExit, .{});
    ^
(process terminated by signal)
負の数の符号なし整数への変換
コンパイル時:

comptime {
    var value: i32 = -1;
    const unsigned = @intCast(u32, value);
    _ = unsigned;
}
$ zig test test.zig
docgen_tmp/test.zig:3:36: error: type 'u32' cannot represent integer value '-1'
    const unsigned = @intCast(u32, value);
                                   ^~~~~
ランタイム時:

const std = @import("std");

pub fn main() void {
    var value: i32 = -1;
    var unsigned = @intCast(u32, value);
    std.debug.print("value: {}\n", .{unsigned});
}
$ zig build-exe test.zig

$ ./test
thread 1639895 panic: attempt to cast negative value to unsigned integer
docgen_tmp/test.zig:5:5: 0x21020d in main (test)
    var unsigned = @intCast(u32, value);
    ^
/home/andy/tmp/zig/lib/std/start.zig:596:22: 0x20f89b in posixCallMainAndExit (test)
            root.main();
                     ^
/home/andy/tmp/zig/lib/std/start.zig:368:5: 0x20f361 in _start (test)
    @call(.{ .modifier = .never_inline }, posixCallMainAndExit, .{});
    ^
(process terminated by signal)
符号なし整数の最大値を得るには, std.math.maxInt を使用します. 

キャストによるデータの切り捨て
コンパイル時:

comptime {
    const spartan_count: u16 = 300;
    const byte = @intCast(u8, spartan_count);
    _ = byte;
}
$ zig test test.zig
docgen_tmp/test.zig:3:31: error: type 'u8' cannot represent integer value '300'
    const byte = @intCast(u8, spartan_count);
                              ^~~~~~~~~~~~~
ランタイム時:

const std = @import("std");

pub fn main() void {
    var spartan_count: u16 = 300;
    const byte = @intCast(u8, spartan_count);
    std.debug.print("value: {}\n", .{byte});
}
$ zig build-exe test.zig

$ ./test
thread 1639955 panic: integer cast truncated bits
docgen_tmp/test.zig:5:5: 0x2101c6 in main (test)
    const byte = @intCast(u8, spartan_count);
    ^
/home/andy/tmp/zig/lib/std/start.zig:596:22: 0x20f84b in posixCallMainAndExit (test)
            root.main();
                     ^
/home/andy/tmp/zig/lib/std/start.zig:368:5: 0x20f311 in _start (test)
    @call(.{ .modifier = .never_inline }, posixCallMainAndExit, .{});
    ^
(process terminated by signal)
ビットを切り捨てるには, @truncate を使用します. 

整数のオーバーフロー
デフォルトの操作
以下の演算子は, 整数のオーバーフローを引き起こす可能性があります. 

+ (加算)
- (減算)
- (否定)
* (乗算)
/ (除算)
@divTrunc (除算)
@divFloor (除算)
@divExact (除算)
コンパイル時に加算を行う例:

comptime {
    var byte: u8 = 255;
    byte += 1;
}
$ zig test test.zig
docgen_tmp/test.zig:3:10: error: overflow of integer type 'u8' with value '256'
    byte += 1;
    ~~~~~^~~~
ランタイム時:

const std = @import("std");

pub fn main() void {
    var byte: u8 = 255;
    byte += 1;
    std.debug.print("value: {}\n", .{byte});
}
$ zig build-exe test.zig

$ ./test
thread 1640016 panic: integer overflow
docgen_tmp/test.zig:5:5: 0x2101b4 in main (test)
    byte += 1;
    ^
/home/andy/tmp/zig/lib/std/start.zig:596:22: 0x20f83b in posixCallMainAndExit (test)
            root.main();
                     ^
/home/andy/tmp/zig/lib/std/start.zig:368:5: 0x20f301 in _start (test)
    @call(.{ .modifier = .never_inline }, posixCallMainAndExit, .{});
    ^
(process terminated by signal)
標準ライブラリの数学関数
標準ライブラリで提供されるこれらの関数は, 起こりうるエラーを返します. 

@import("std").math.add
@import("std").math.sub
@import("std").math.mul
@import("std").math.divTrunc
@import("std").math.divFloor
@import("std").math.divExact
@import("std").math.shl
加算のオーバーフローをキャッチする例:

const math = @import("std").math;
const print = @import("std").debug.print;
pub fn main() !void {
    var byte: u8 = 255;

    byte = if (math.add(u8, byte, 1)) |result| result else |err| {
        print("unable to add one: {s}\n", .{@errorName(err)});
        return err;
    };

    print("result: {}\n", .{byte});
}
$ zig build-exe test.zig

$ ./test
unable to add one: Overflow
error: Overflow
/home/andy/tmp/zig/lib/std/math.zig:484:5: 0x210023 in add__anon_2890 (test)
    return if (@addWithOverflow(T, a, b, &answer)) error.Overflow else answer;
    ^
docgen_tmp/test.zig:8:9: 0x20ff3d in main (test)
        return err;
        ^
組み込みのオーバーフロー関数
これらの組み込み関数は, オーバーフローが発生したかどうかを bool で返し, またオーバーフローしたビットを返します. 

@addWithOverflow
@subWithOverflow
@mulWithOverflow
@shlWithOverflow
addWithOverflow の例です:

const print = @import("std").debug.print;
pub fn main() void {
    var byte: u8 = 255;

    var result: u8 = undefined;
    if (@addWithOverflow(u8, byte, 10, &result)) {
        print("overflowed result: {}\n", .{result});
    } else {
        print("result: {}\n", .{result});
    }
}
$ zig build-exe test.zig

$ ./test
overflowed result: 9
ラッピング演算
左シフトのオーバーフロー
右シフトのオーバーフロー
ゼロによる除算
ゼロによる除算
正確な割り算の余り
Null のアンラップ試行
アンラップエラーの試行
無効なエラーコード
無効な列挙型キャスト
無効なエラーセットキャスト
ポインターの位置が正しくありません. 
誤ったユニオンフィールドアクセス
範囲外の浮動小数点数から整数へのキャスト
ポインタキャストの無効な Null
メモリ
Zig 言語はプログラマに代わってメモリ管理を行いません. このため, Zig にはランタイムがなく, Zig のコードはリアルタイム・ソフトウェア, OS カーネル, 組み込みデバイス, 低遅延サーバなど, 多くの環境でシームレスに動作します. その結果, Zig のプログラマは常にこの問いに答えられなければなりません. 

バイトはどこにある？

Zig と同じく, C 言語でもメモリ管理は手動で行います. しかし Zig とは異なり, C にはデフォルトのアロケータ, つまり malloc, realloc, free があります. libc とリンクするとき, Zig はこのアロケーターを std.heap.c_allocator で公開します. しかし, 慣習として, Zig にはデフォルトのアロケータはありません. 代わりに, 割り当てが必要な関数は Allocator パラメータを受け取ります. 同様に, std.ArrayList のようなデータ構造もその初期化関数で Allocator パラメータを受け付けます. 

const std = @import("std");
const Allocator = std.mem.Allocator;
const expect = std.testing.expect;

test "using an allocator" {
    var buffer: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    const result = try concat(allocator, "foo", "bar");
    try expect(std.mem.eql(u8, "foobar", result));
}

fn concat(allocator: Allocator, a: []const u8, b: []const u8) ![]u8 {
    const result = try allocator.alloc(u8, a.len + b.len);
    std.mem.copy(u8, result, a);
    std.mem.copy(u8, result[a.len..], b);
    return result;
}
$ zig test allocator.zig
1/1 test.using an allocator... OK
All 1 tests passed.
上記の例では, 100 バイトのスタックメモリが FixedBufferAllocator の初期化に使われ, それが関数に渡されます. 便宜上, グローバルな FixedBufferAllocator が std.testing.allocator で用意されており, 基本的なリーク検出も行うことができます. 

Zig には std.heap.GeneralPurposeAllocator でインポート可能な汎用アロケータがあります. しかし, やはり, アロケータの選択ガイドに従うことが推奨されます. 

アロケーターの選択
どのアロケーターを使用するかは, 様々な要因によって決まります. 以下にフローチャートを示しますので, 判断の参考にしてください. 

ライブラリを作っているのですか？この場合, アロケータをパラメータとして受け取り, ライブラリのユーザがどのアロケータを使うかを決定するのがベストです. 
libc をリンクしていますか? この場合, 少なくともメインのアロケータは std.heap.c_allocator が正しい選択だと思われます. 
必要なバイト数の最大値は, コンパイル時に分かっている数で制限されていますか? この場合, スレッドセーフが必要かどうかによって std.heap.FixedBufferAllocator か std.heap.ThreadSafeFixedBufferAllocator を使ってください. 
あなたのプログラムはコマンドラインアプリケーションで, 基本的な循環パターンを持たずに最初から最後まで実行され（ビデオゲームのメインループやウェブサーバのリクエストハンドラなど）, 最後にすべてを一度に解放することに意味があるようなものでしょうか？このような場合, このパターンに従うことをお勧めします. 
const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const ptr = try allocator.create(i32);
    std.debug.print("ptr={*}\n", .{ptr});
}
$ zig build-exe cli_allocation.zig

$ ./cli_allocation
ptr=i32@7f194545d018
この種のアロケータを使用する場合, 手動で何かを解放する必要はありません. arena.deinit() を呼び出せば, すべてが一度に解放されます. 

アロケーションはビデオゲームのメインループや Web サーバのリクエストハンドラのような周期的なパターンの一部になっていますか？例えば, ビデオゲームのフレームが完全にレンダリングされた後や, ウェブサーバーのリクエストが処理された後など, サイクルの終わりにすべてのアロケーションを一度に解放できる場合, std.heap.ArenaAllocator は素晴らしい候補となります. 前の箇条書きで示したように, これによってアリーナ全体を一度に解放することができます. また, メモリの上限を設定できる場合は, std.heap.FixedBufferAllocator を使用すると, さらに最適化できることに注意しましょう. 
テストを書いていて, error.OutOfMemory が正しく処理されることを確認したいですか？この場合は std.testing.FailingAllocator を使ってください. 
テストを書いていますか？この場合は std.testing.allocator を使ってください. 
最後に, 上記のどれにも当てはまらない場合は, 汎用のアロケータが必要です. Zig の汎用アロケータは, 設定オプションの comptime 構造体を受け取り, 型を返す関数として提供されている. 一般的には, メイン関数に std.heap.GeneralPurposeAllocator をひとつセットアップし, アプリケーションの様々な部分にそのアロケータやサブアロケータを渡していくことになる. 
また, アロケータの実装を検討することもできます. 
バイトはどこにある？
"foo" のような文字列リテラルは, グローバル定数データセクションにあります. このため, このように文字列リテラルをミュータブルスライスに渡すとエラーになります. 

fn foo(s: []u8) void {
    _ = s;
}

test "string literal to mutable slice" {
    foo("hello");
}
$ zig test test.zig
docgen_tmp/test.zig:6:9: error: expected type '[]u8', found '*const [5:0]u8'
    foo("hello");
        ^~~~~~~
docgen_tmp/test.zig:6:9: note: cast discards const qualifier
しかし, スライスを一定にすれば, うまくいくのです. 

fn foo(s: []const u8) void {
    _ = s;
}

test "string literal to constant slice" {
    foo("hello");
}
$ zig test strlit.zig
1/1 test.string literal to constant slice... OK
All 1 tests passed.
文字列リテラルと同様に, コンパイル時に値が分かっている const 宣言は, グローバル定数データセクションに格納されます. また, コンパイル時変数もグローバル定数データセクションに格納されます. 

関数内の var 宣言は, その関数のスタックフレームに格納されます. 関数が戻ると, 関数のスタックフレームにある変数へのポインタは無効な参照となり, その参照解除は未確認の未定義動作となります. 

トップレベルまたは構造体宣言の var 宣言は, グローバルデータセクションに格納されます. 

allocator.alloc や allocator.create で確保されたメモリの格納場所は, アロケータの実装によって決定される. 

アロケータの実装
Zig プログラマは Allocator インターフェースを満たすことで, 自分自身のアロケーターを実装することができます. そのためには, std/mem.zig にあるドキュメントコメントをよく読んで,  allocFn と resizeFn を用意する必要があります. 

インスピレーションを得るために, 多くのアロケータの例を見ることができます. std/heap.zig と std.heap.GeneralPurposeAllocator を見てください. 

ヒープ割り当ての失敗
多くのプログラミング言語では, ヒープ割り当てに失敗した場合, 無条件にクラッシュすることで対処しています. Zig のプログラマは, 慣習として, これが満足のいく解決策であるとは考えていません. その代わりに, error.OutOfMemory はヒープ割り当ての失敗を表し, Zig ライブラリはヒープ割り当ての失敗で処理が正常に完了しなかったときはいつでもこのエラーコードを返します. 

Linux などの一部の OS では, デフォルトでメモリのオーバーコミットが有効になっているため, ヒープ割り当ての失敗を処理することは無意味であると主張する人もいます. この理由には多くの問題があります. 

オーバーコミット機能を持つのは一部のオペレーティング・システムだけです. 
Linux はデフォルトでオーバーコミットが有効になっていますが, 設定可能です. 
Windows はオーバーコミットしません. 
組み込みシステムにはオーバーコミットがありません. 
趣味の OS では, オーバーコミットがある場合とない場合があります. 
リアルタイムシステムの場合, オーバーコミットがないだけでなく, 通常, アプリケーションごとにメモリの最大量があらかじめ決められています. 
ライブラリを書くときの主な目的の 1 つは, コードの再利用です. アロケーションの失敗を正しく処理することで, ライブラリはより多くのコンテキストで再利用されるようになります. 
オーバーコミットが有効であることに依存するようになったソフトウェアもありますが, その存在は数え切れないほどのユーザ体験の破壊の原因になっています. オーバーコミットを有効にしたシステム, 例えばデフォルト設定の Linux では, メモリが枯渇しそうになると, システムがロックして使えなくなる. このとき, OOM Killer はヒューリスティックに基づき kill するアプリケーションを選択します. この非決定的な判断により, 重要なプロセスが強制終了されることが多く, システムを正常に戻すことができないことがよくあります. 
再帰
再帰は, ソフトウェアのモデリングにおいて基本的なツールである. しかし, しばしば見落とされがちな問題があります: 無制限のメモリ割り当てです. 

再帰は Zig で活発に実験されている分野なので, ここにあるドキュメントは最終的なものではありません. 0.3.0 のリリースノートで, 再帰の状況を要約して読むことができます. 

簡単にまとめると, 現在のところ再帰は期待通りに動作しています. Zig のコードはまだスタックオーバーフローから保護されていませんが, Zig の将来のバージョンでは, Zig のコードからのある程度の協力が必要ですが, そのような保護を提供することが予定されています. 

ライフタイムと所有権
ポインタの指すメモリが利用できなくなったときに, ポインタがアクセスされないようにするのは, Zig プログラマの責任です. スライスは他のメモリを参照するという点で, ポインタの一種であることに注意してください. 

バグを防ぐために, ポインタを扱うときに従うと便利な規約がいくつかあります. 一般に, 関数がポインターを返す場合, その関数のドキュメントでは, 誰がそのポインターを「所有」しているかを説明する必要があります. この概念は, プログラマがポインタを解放することが適切である場合, そのタイミングを判断するのに役立ちます. 

例えば, 関数のドキュメントに「返されたメモリは呼び出し元が所有する」と書かれていた場合, その関数を呼び出すコードは, いつそのメモリを解放するかという計画を持っていなければなりません. このような場合, おそらく関数は Allocator パラメータを受け取ります. 

時には, ポインタの寿命はもっと複雑な場合があります. 例えば, std.ArrayList(T).items スライスは, 新しい要素を追加するなどしてリストのサイズが次に変更されるまで有効である. 

関数やデータ構造の API ドキュメントでは, ポインタの所有権と有効期限について細心の注意を払って説明する必要があります. 所有権とは, ポインタが参照するメモリを解放する責任が誰にあるかということであり, 寿命とは, メモリがアクセス不能になる時点（未定義動作が発生しないように）を決めることである. 

Compile Variables
Root Source File

# Zig ビルドシステム
Zig Build System は, プロジェクトをビルドするために必要なロジックを宣言するための, クロスプラットフォームで依存性のない方法を提供します. このシステムでは, プロジェクトをビルドするためのロジックは build.zig ファイルに記述され, Zig Build System API を使ってビルドアーチファクトやその他のタスクを宣言し, 設定することができます. 

ビルドシステムが支援するタスクの例をいくつか挙げます. 

Zig コンパイラの実行によるビルドの成果物の作成. これには, C や C++のソースコードだけでなく, Zig のソースコードのビルドも含まれます. 
ユーザが設定したオプションを取得し, そのオプションを使用してビルドを設定する. 
Zig のコードからインポート可能なファイルを提供することで, ビルド構成を comptime の値として表面化させる. 
ビルド内容をキャッシュし, 不要なステップの繰り返しを回避します. 
ビルド・アーティファクトやシステムにインストールされたツールの実行
テストを実行し, ビルド・アーティファクトの実行による出力が期待値と一致することを確認する. 
コードベースまたはそのサブセットに対して zig fmt を実行する. 
カスタムタスク. 
ビルドシステムを使用するには, zig build --help を実行すると, コマンドライン使用法のヘルプメニューが表示されます. 
これには, build.zig スクリプトで宣言されたプロジェクト固有のオプションが含まれます. 


### Freestanding
Web ブラウザや nodejs のようなホスト環境では, 独立した OS ターゲットを使ってダイナミックライブラリとしてビルドします. WebAssembly にコンパイルされた Zig のコードを nodejs で実行する例を示します. 

### WASI
Zig の WebAssembly System Interface (WASI) のサポートは現在活発に開発中です. 標準ライブラリの使用とコマンドライン引数の読み込みの例. 

より興味深い例は, ランタイムからプレオープンのリストを抽出することです. これは現在標準ライブラリで std.fs.wasi.PreopenList を介してサポートされています. 

### Targets
Zig は, LLVM がサポートする全てのターゲットのコード生成をサポートしています. 以下は, Linux x86_64 コンピュータで zig ターゲットを実行したときの様子です. 

Zig 標準ライブラリ (@import("std")) は, アーキテクチャ, 環境, オペレーティングシステムを 抽象化しているため, より多くのプラットフォームをサポートするために追加作業が必要になります. しかし, すべての標準ライブラリのコードがオペレーティングシステムの抽象化を必要とするわけではないので, 汎用データ構造のようなものは上記のすべてのプラットフォームで動作します. 

現在, Zig 標準ライブラリがサポートしているターゲットの一覧は以下の通りです. 
Linux x86_64 Windows x86_64 macOS x86_64

## スタイルガイド
これらのコーディング規約はコンパイラによって強制されるものではありませんが, 誰かが Zig コーディングスタイルについて合意した権威を指摘したい場合に参照するポイントを提供するために, コンパイラと一緒にこの文書に収録されています. 

ホワイトスペース
4 スペースインデント
中括弧は, 折り返す必要がない限り, 同じ行に開く
リストが 2 より長い場合, 各項目を独立した行に置き, 最後に余分なカンマを置く機能を行使する
行の長さ: 100 を目安に, 常識的な範囲で
名前 (Names)
大雑把に言うと, camelCaseFunctionName,  TitleCaseTypeName, snake_case_variable_name です. より正確には

x が型の場合, x は TitleCase にすべきです. ただし, フィールドが 0 個の構造体で, インスタンス化されることがない場合は除きます. この場合, それは「名前空間」であるとみなされ, snake_case が使用されます
x が呼び出し可能で, x の戻り値が type である場合, x は TitleCase であるべきです. 
x が他に呼び出し可能な場合, x は camelCase であるべきである. 
そうでなければ, x は snake_case であるべきです. 
頭字語, イニシャリズム, 固有名詞など, 英語の書き言葉で大文字と小文字の区別があるものは, 他の単語と同じように命名規則が適用されます. たった 2 文字の頭字語であっても, 命名規則が適用されます. 

ファイル名は, 型と名前空間の 2 つのカテゴリに分類されます. ファイル（暗黙のうちに構造体）がトップレベルのフィールドを持つ場合, フィールドを持つ他の構造体と同様に TitleCase を使って命名する必要があります. そうでない場合は, snake_case を使用します. ディレクトリ名は snake_case を使用します. 

これらは一般的な経験則であり, もし異なることをするのが理にかなっているのであれば, 理にかなっていることをするのが良いでしょう. 例えば, ENOENT のような確立された慣習がある場合は, その慣習に従います. 

例 (Examples)
const namespace_name = @import("dir_name/file_name.zig");
const TypeName = @import("dir_name/TypeName.zig");
var global_var: i32 = undefined;
const const_name = 42;
const primitive_type_alias = f32;
const string_alias = []u8;

const StructName = struct {
    field: i32,
};
const StructAlias = StructName;

fn functionName(param_name: TypeName) void {
    var functionPointer = functionName;
    functionPointer();
    functionPointer = otherFunction;
    functionPointer();
}
const functionAlias = functionName;

fn ListTemplateFunction(comptime ChildType: type, comptime fixed_size: usize) type {
    return List(ChildType, fixed_size);
}

fn ShortList(comptime T: type, comptime n: usize) type {
    return struct {
        field_name: [n]T,
        fn methodName() void {}
    };
}

// The word XML loses its casing when used in Zig identifiers.
const xml_document =
    \\<?xml version="1.0" encoding="UTF-8"?>
    \\<document>
    \\</document>
;
const XmlParser = struct {
    field: i32,
};

// The initials BE (Big Endian) are just another word in Zig identifier names.
fn readU32Be() u32 {}
その他の例については, Zig 標準ライブラリを参照してください. 

Doc Comment Guidance
文書化されるものの名前に基づいて, 冗長な情報はすべて省略します. 
IDE や他のツールがより良いヘルプテキストを提供するのに役立つので, 複数の類似した関数に情報を重複させることが推奨されます. 
違反すると未定義の動作を引き起こす不変条件を示すには, assume という単語を使用します. 
違反したときに安全チェックされた未定義動作を引き起こす不変量を示すには, assert という単語を使用します. 
ソースコードのエンコーディング
Zig のソースコードは UTF-8 でエンコードされています. UTF-8 のバイト列が無効な場合, コンパイルエラーになります. 

すべての Zig ソースコード（コメントも含む）において, 絶対に許されないコードポイントがあります. 

U+000a （LF）, U+000d （CR）, U+0009 （HT）を除くアスキー制御文字. U+0000 ～ U+0008, U+000b ～ U+000c, U+000e ～ U+0001f, U+007f.
非 Ascii Unicode の改行. U+0085 (NEL), U+2028 (LS), U+2029 (PS). 
LF (バイト値 0x0a, コードポイント U+000a, 'Ъ') は Zig ソースコードにおける行終端記号です. このバイト値は, ファイルの最終行を除く zig ソース・コードのすべての行を終了させます. 空ではないソース・ファイルは空行で終わることが推奨されており, その場合, 最後のバイトは 0x0a (LF) になります. 

各 LF の直前に 1 つの CR (バイト値 0x0d, コードポイント U+000d, ' \r') を置くと Windows スタイルの行末になりますが, これは推奨されません. 他の文脈での CR は許可されない. 

HT ハードタブ (バイト値 0x09, コードポイント U+0009, '\t') は, SP スペース (バイト値 0x20, コードポイント U+0020, ' ') と互換性がありますが, ハードタブの使用は推奨されません. 文法参照. 

ソースファイル上で zig fmt を実行すると, ここで述べたすべての推奨事項が実装されることに注意してください. また, stage1 コンパイラはまだ CR や HT の制御文字をサポートしていないことに注意してください. 

Zig ソースコードを読むツールは, ソースコードが正しい Zig コードであると仮定される場合, 仮定を行うことができることに注意してください. 例えば, 行末を識別する場合, /neav 検索で「/n/」, advanced 検索で「/rn?|[ \nu0085] /」を使用すれば, 行末を正しく識別することが可能です. 例えば, 行の最初のトークンの前にある空白を識別する場合, ツールは/[ \t]/ のような単純な検索, または/㎤ のような詳細検索のいずれかを使用でき, どちらの場合でも空白は正しく識別される. 

付録
コンテナ
Zig におけるコンテナとは, 変数や関数の宣言を保持するための名前空間として機能する構文的な構成要素のことです. コンテナはインスタンス化可能な型定義でもある. 構造体, 列挙体, 共用体, 不透明体, そして Zig のソースファイル自体もコンテナです. 

コンテナ（Zig ソースファイルを除く）は中括弧で定義を囲みますが, ブロックや関数と混同しないでください. コンテナには文は含まれません. 

文法
Root <- skip container_doc_comment? ContainerMembers eof

# *** Top level ***
ContainerMembers <- ContainerDeclarations (ContainerField COMMA)* (ContainerField / ContainerDeclarations)

ContainerDeclarations
    <- TestDecl ContainerDeclarations
     / TopLevelComptime ContainerDeclarations
     / doc_comment? KEYWORD_pub? TopLevelDecl ContainerDeclarations
     /

TestDecl <- doc_comment? KEYWORD_test STRINGLITERALSINGLE? Block

TopLevelComptime <- doc_comment? KEYWORD_comptime BlockExpr

TopLevelDecl
    <- (KEYWORD_export / KEYWORD_extern STRINGLITERALSINGLE? / (KEYWORD_inline / KEYWORD_noinline))? FnProto (SEMICOLON / Block)
     / (KEYWORD_export / KEYWORD_extern STRINGLITERALSINGLE?)? KEYWORD_threadlocal? VarDecl
     / KEYWORD_usingnamespace Expr SEMICOLON

FnProto <- KEYWORD_fn IDENTIFIER? LPAREN ParamDeclList RPAREN ByteAlign? LinkSection? CallConv? EXCLAMATIONMARK? TypeExpr

VarDecl <- (KEYWORD_const / KEYWORD_var) IDENTIFIER (COLON TypeExpr)? ByteAlign? LinkSection? (EQUAL Expr)? SEMICOLON

ContainerField <- doc_comment? KEYWORD_comptime? IDENTIFIER (COLON (KEYWORD_anytype / TypeExpr) ByteAlign?)? (EQUAL Expr)?

# *** Block Level ***
Statement
    <- KEYWORD_comptime? VarDecl
     / KEYWORD_comptime BlockExprStatement
     / KEYWORD_nosuspend BlockExprStatement
     / KEYWORD_suspend BlockExprStatement
     / KEYWORD_defer BlockExprStatement
     / KEYWORD_errdefer Payload? BlockExprStatement
     / IfStatement
     / LabeledStatement
     / SwitchExpr
     / AssignExpr SEMICOLON

IfStatement
    <- IfPrefix BlockExpr ( KEYWORD_else Payload? Statement )?
     / IfPrefix AssignExpr ( SEMICOLON / KEYWORD_else Payload? Statement )

LabeledStatement <- BlockLabel? (Block / LoopStatement)

LoopStatement <- KEYWORD_inline? (ForStatement / WhileStatement)

ForStatement
    <- ForPrefix BlockExpr ( KEYWORD_else Statement )?
     / ForPrefix AssignExpr ( SEMICOLON / KEYWORD_else Statement )

WhileStatement
    <- WhilePrefix BlockExpr ( KEYWORD_else Payload? Statement )?
     / WhilePrefix AssignExpr ( SEMICOLON / KEYWORD_else Payload? Statement )

BlockExprStatement
    <- BlockExpr
     / AssignExpr SEMICOLON

BlockExpr <- BlockLabel? Block

# *** Expression Level ***
AssignExpr <- Expr (AssignOp Expr)?

Expr <- BoolOrExpr

BoolOrExpr <- BoolAndExpr (KEYWORD_or BoolAndExpr)*

BoolAndExpr <- CompareExpr (KEYWORD_and CompareExpr)*

CompareExpr <- BitwiseExpr (CompareOp BitwiseExpr)?

BitwiseExpr <- BitShiftExpr (BitwiseOp BitShiftExpr)*

BitShiftExpr <- AdditionExpr (BitShiftOp AdditionExpr)*

AdditionExpr <- MultiplyExpr (AdditionOp MultiplyExpr)*

MultiplyExpr <- PrefixExpr (MultiplyOp PrefixExpr)*

PrefixExpr <- PrefixOp* PrimaryExpr

PrimaryExpr
    <- AsmExpr
     / IfExpr
     / KEYWORD_break BreakLabel? Expr?
     / KEYWORD_comptime Expr
     / KEYWORD_nosuspend Expr
     / KEYWORD_continue BreakLabel?
     / KEYWORD_resume Expr
     / KEYWORD_return Expr?
     / BlockLabel? LoopExpr
     / Block
     / CurlySuffixExpr

IfExpr <- IfPrefix Expr (KEYWORD_else Payload? Expr)?

Block <- LBRACE Statement* RBRACE

LoopExpr <- KEYWORD_inline? (ForExpr / WhileExpr)

ForExpr <- ForPrefix Expr (KEYWORD_else Expr)?

WhileExpr <- WhilePrefix Expr (KEYWORD_else Payload? Expr)?

CurlySuffixExpr <- TypeExpr InitList?

InitList
    <- LBRACE FieldInit (COMMA FieldInit)* COMMA? RBRACE
     / LBRACE Expr (COMMA Expr)* COMMA? RBRACE
     / LBRACE RBRACE

TypeExpr <- PrefixTypeOp* ErrorUnionExpr

ErrorUnionExpr <- SuffixExpr (EXCLAMATIONMARK TypeExpr)?

SuffixExpr
    <- KEYWORD_async PrimaryTypeExpr SuffixOp* FnCallArguments
     / PrimaryTypeExpr (SuffixOp / FnCallArguments)*

PrimaryTypeExpr
    <- BUILTINIDENTIFIER FnCallArguments
     / CHAR_LITERAL
     / ContainerDecl
     / DOT IDENTIFIER
     / DOT InitList
     / ErrorSetDecl
     / FLOAT
     / FnProto
     / GroupedExpr
     / LabeledTypeExpr
     / IDENTIFIER
     / IfTypeExpr
     / INTEGER
     / KEYWORD_comptime TypeExpr
     / KEYWORD_error DOT IDENTIFIER
     / KEYWORD_anyframe
     / KEYWORD_unreachable
     / STRINGLITERAL
     / SwitchExpr

ContainerDecl <- (KEYWORD_extern / KEYWORD_packed)? ContainerDeclAuto

ErrorSetDecl <- KEYWORD_error LBRACE IdentifierList RBRACE

GroupedExpr <- LPAREN Expr RPAREN

IfTypeExpr <- IfPrefix TypeExpr (KEYWORD_else Payload? TypeExpr)?

LabeledTypeExpr
    <- BlockLabel Block
     / BlockLabel? LoopTypeExpr

LoopTypeExpr <- KEYWORD_inline? (ForTypeExpr / WhileTypeExpr)

ForTypeExpr <- ForPrefix TypeExpr (KEYWORD_else TypeExpr)?

WhileTypeExpr <- WhilePrefix TypeExpr (KEYWORD_else Payload? TypeExpr)?

SwitchExpr <- KEYWORD_switch LPAREN Expr RPAREN LBRACE SwitchProngList RBRACE

# *** Assembly ***
AsmExpr <- KEYWORD_asm KEYWORD_volatile? LPAREN Expr AsmOutput? RPAREN

AsmOutput <- COLON AsmOutputList AsmInput?

AsmOutputItem <- LBRACKET IDENTIFIER RBRACKET STRINGLITERAL LPAREN (MINUSRARROW TypeExpr / IDENTIFIER) RPAREN

AsmInput <- COLON AsmInputList AsmClobbers?

AsmInputItem <- LBRACKET IDENTIFIER RBRACKET STRINGLITERAL LPAREN Expr RPAREN

AsmClobbers <- COLON StringList

# *** Helper grammar ***
BreakLabel <- COLON IDENTIFIER

BlockLabel <- IDENTIFIER COLON

FieldInit <- DOT IDENTIFIER EQUAL Expr

WhileContinueExpr <- COLON LPAREN AssignExpr RPAREN

LinkSection <- KEYWORD_linksection LPAREN Expr RPAREN

# Fn specific
CallConv <- KEYWORD_callconv LPAREN Expr RPAREN

ParamDecl
    <- doc_comment? (KEYWORD_noalias / KEYWORD_comptime)? (IDENTIFIER COLON)? ParamType
     / DOT3

ParamType
    <- KEYWORD_anytype
     / TypeExpr

# Control flow prefixes
IfPrefix <- KEYWORD_if LPAREN Expr RPAREN PtrPayload?

WhilePrefix <- KEYWORD_while LPAREN Expr RPAREN PtrPayload? WhileContinueExpr?

ForPrefix <- KEYWORD_for LPAREN Expr RPAREN PtrIndexPayload

# Payloads
Payload <- PIPE IDENTIFIER PIPE

PtrPayload <- PIPE ASTERISK? IDENTIFIER PIPE

PtrIndexPayload <- PIPE ASTERISK? IDENTIFIER (COMMA IDENTIFIER)? PIPE


# Switch specific
SwitchProng <- SwitchCase EQUALRARROW PtrPayload? AssignExpr

SwitchCase
    <- SwitchItem (COMMA SwitchItem)* COMMA?
     / KEYWORD_else

SwitchItem <- Expr (DOT3 Expr)?

# Operators
AssignOp
    <- ASTERISKEQUAL
     / SLASHEQUAL
     / PERCENTEQUAL
     / PLUSEQUAL
     / MINUSEQUAL
     / LARROW2EQUAL
     / RARROW2EQUAL
     / AMPERSANDEQUAL
     / CARETEQUAL
     / PIPEEQUAL
     / ASTERISKPERCENTEQUAL
     / PLUSPERCENTEQUAL
     / MINUSPERCENTEQUAL
     / EQUAL

CompareOp
    <- EQUALEQUAL
     / EXCLAMATIONMARKEQUAL
     / LARROW
     / RARROW
     / LARROWEQUAL
     / RARROWEQUAL

BitwiseOp
    <- AMPERSAND
     / CARET
     / PIPE
     / KEYWORD_orelse
     / KEYWORD_catch Payload?

BitShiftOp
    <- LARROW2
     / RARROW2

AdditionOp
    <- PLUS
     / MINUS
     / PLUS2
     / PLUSPERCENT
     / MINUSPERCENT

MultiplyOp
    <- PIPE2
     / ASTERISK
     / SLASH
     / PERCENT
     / ASTERISK2
     / ASTERISKPERCENT

PrefixOp
    <- EXCLAMATIONMARK
     / MINUS
     / TILDE
     / MINUSPERCENT
     / AMPERSAND
     / KEYWORD_try
     / KEYWORD_await

PrefixTypeOp
    <- QUESTIONMARK
     / KEYWORD_anyframe MINUSRARROW
     / SliceTypeStart (ByteAlign / KEYWORD_const / KEYWORD_volatile / KEYWORD_allowzero)*
     / PtrTypeStart (KEYWORD_align LPAREN Expr (COLON INTEGER COLON INTEGER)? RPAREN / KEYWORD_const / KEYWORD_volatile / KEYWORD_allowzero)*
     / ArrayTypeStart

SuffixOp
    <- LBRACKET Expr (DOT2 (Expr? (COLON Expr)?)?)? RBRACKET
     / DOT IDENTIFIER
     / DOTASTERISK
     / DOTQUESTIONMARK

FnCallArguments <- LPAREN ExprList RPAREN

# Ptr specific
SliceTypeStart <- LBRACKET (COLON Expr)? RBRACKET

PtrTypeStart
    <- ASTERISK
     / ASTERISK2
     / LBRACKET ASTERISK (LETTERC / COLON Expr)? RBRACKET

ArrayTypeStart <- LBRACKET Expr (COLON Expr)? RBRACKET

# ContainerDecl specific
ContainerDeclAuto <- ContainerDeclType LBRACE container_doc_comment? ContainerMembers RBRACE

ContainerDeclType
    <- KEYWORD_struct
     / KEYWORD_opaque
     / KEYWORD_enum (LPAREN Expr RPAREN)?
     / KEYWORD_union (LPAREN (KEYWORD_enum (LPAREN Expr RPAREN)? / Expr) RPAREN)?

# Alignment
ByteAlign <- KEYWORD_align LPAREN Expr RPAREN

# Lists
IdentifierList <- (doc_comment? IDENTIFIER COMMA)* (doc_comment? IDENTIFIER)?

SwitchProngList <- (SwitchProng COMMA)* SwitchProng?

AsmOutputList <- (AsmOutputItem COMMA)* AsmOutputItem?

AsmInputList <- (AsmInputItem COMMA)* AsmInputItem?

StringList <- (STRINGLITERAL COMMA)* STRINGLITERAL?

ParamDeclList <- (ParamDecl COMMA)* ParamDecl?

ExprList <- (Expr COMMA)* Expr?

# *** Tokens ***
eof <- !.
bin <- [01]
bin_ <- '_'? bin
oct <- [0-7]
oct_ <- '_'? oct
hex <- [0-9a-fA-F]
hex_ <- '_'? hex
dec <- [0-9]
dec_ <- '_'? dec

bin_int <- bin bin_*
oct_int <- oct oct_*
dec_int <- dec dec_*
hex_int <- hex hex_*

ox80_oxBF <- [\200-\277]
oxF4 <- '\364'
ox80_ox8F <- [\200-\217]
oxF1_oxF3 <- [\361-\363]
oxF0 <- '\360'
ox90_0xBF <- [\220-\277]
oxEE_oxEF <- [\356-\357]
oxED <- '\355'
ox80_ox9F <- [\200-\237]
oxE1_oxEC <- [\341-\354]
oxE0 <- '\340'
oxA0_oxBF <- [\240-\277]
oxC2_oxDF <- [\302-\337]

# From https://lemire.me/blog/2018/05/09/how-quickly-can-you-check-that-a-string-is-valid-unicode-utf-8/
# First Byte      Second Byte     Third Byte      Fourth Byte
# [0x00,0x7F]
# [0xC2,0xDF]     [0x80,0xBF]
#    0xE0         [0xA0,0xBF]     [0x80,0xBF]
# [0xE1,0xEC]     [0x80,0xBF]     [0x80,0xBF]
#    0xED         [0x80,0x9F]     [0x80,0xBF]
# [0xEE,0xEF]     [0x80,0xBF]     [0x80,0xBF]
#    0xF0         [0x90,0xBF]     [0x80,0xBF]     [0x80,0xBF]
# [0xF1,0xF3]     [0x80,0xBF]     [0x80,0xBF]     [0x80,0xBF]
#    0xF4         [0x80,0x8F]     [0x80,0xBF]     [0x80,0xBF]

mb_utf8_literal <-
       oxF4      ox80_ox8F ox80_oxBF ox80_oxBF
     / oxF1_oxF3 ox80_oxBF ox80_oxBF ox80_oxBF
     / oxF0      ox90_0xBF ox80_oxBF ox80_oxBF
     / oxEE_oxEF ox80_oxBF ox80_oxBF
     / oxED      ox80_ox9F ox80_oxBF
     / oxE1_oxEC ox80_oxBF ox80_oxBF
     / oxE0      oxA0_oxBF ox80_oxBF
     / oxC2_oxDF ox80_oxBF

ascii_char_not_nl_slash_squote <- [\000-\011\013-\046-\050-\133\135-\177]

char_escape
    <- "\\x" hex hex
     / "\\u{" hex+ "}"
     / "\\" [nr\\t'"]
char_char
    <- mb_utf8_literal
     / char_escape
     / ascii_char_not_nl_slash_squote

string_char
    <- char_escape
     / [^\\"\n]

container_doc_comment <- ('//!' [^\n]* [ \n]*)+
doc_comment <- ('///' [^\n]* [ \n]*)+
line_comment <- '//' ![!/][^\n]* / '////' [^\n]*
line_string <- ("\\\\" [^\n]* [ \n]*)+
skip <- ([ \n] / line_comment)*

CHAR_LITERAL <- "'" char_char "'" skip
FLOAT
    <- "0x" hex_int "." hex_int ([pP] [-+]? dec_int)? skip
     /      dec_int "." dec_int ([eE] [-+]? dec_int)? skip
     / "0x" hex_int [pP] [-+]? dec_int skip
     /      dec_int [eE] [-+]? dec_int skip
INTEGER
    <- "0b" bin_int skip
     / "0o" oct_int skip
     / "0x" hex_int skip
     /      dec_int   skip
STRINGLITERALSINGLE <- "\"" string_char* "\"" skip
STRINGLITERAL
    <- STRINGLITERALSINGLE
     / (line_string                 skip)+
IDENTIFIER
    <- !keyword [A-Za-z_] [A-Za-z0-9_]* skip
     / "@\"" string_char* "\""                            skip
BUILTINIDENTIFIER <- "@"[A-Za-z_][A-Za-z0-9_]* skip


AMPERSAND            <- '&'      ![=]      skip
AMPERSANDEQUAL       <- '&='               skip
ASTERISK             <- '*'      ![*%=]    skip
ASTERISK2            <- '**'               skip
ASTERISKEQUAL        <- '*='               skip
ASTERISKPERCENT      <- '*%'     ![=]      skip
ASTERISKPERCENTEQUAL <- '*%='              skip
CARET                <- '^'      ![=]      skip
CARETEQUAL           <- '^='               skip
COLON                <- ':'                skip
COMMA                <- ','                skip
DOT                  <- '.'      ![*.?]    skip
DOT2                 <- '..'     ![.]      skip
DOT3                 <- '...'              skip
DOTASTERISK          <- '.*'               skip
DOTQUESTIONMARK      <- '.?'               skip
EQUAL                <- '='      ![>=]     skip
EQUALEQUAL           <- '=='               skip
EQUALRARROW          <- '=>'               skip
EXCLAMATIONMARK      <- '!'      ![=]      skip
EXCLAMATIONMARKEQUAL <- '!='               skip
LARROW               <- '<'      ![<=]     skip
LARROW2              <- '<<'     ![=]      skip
LARROW2EQUAL         <- '<<='              skip
LARROWEQUAL          <- '<='               skip
LBRACE               <- '{'                skip
LBRACKET             <- '['                skip
LPAREN               <- '('                skip
MINUS                <- '-'      ![%=>]    skip
MINUSEQUAL           <- '-='               skip
MINUSPERCENT         <- '-%'     ![=]      skip
MINUSPERCENTEQUAL    <- '-%='              skip
MINUSRARROW          <- '->'               skip
PERCENT              <- '%'      ![=]      skip
PERCENTEQUAL         <- '%='               skip
PIPE                 <- '|'      ![|=]     skip
PIPE2                <- '||'               skip
PIPEEQUAL            <- '|='               skip
PLUS                 <- '+'      ![%+=]    skip
PLUS2                <- '++'               skip
PLUSEQUAL            <- '+='               skip
PLUSPERCENT          <- '+%'     ![=]      skip
PLUSPERCENTEQUAL     <- '+%='              skip
LETTERC              <- 'c'                skip
QUESTIONMARK         <- '?'                skip
RARROW               <- '>'      ![>=]     skip
RARROW2              <- '>>'     ![=]      skip
RARROW2EQUAL         <- '>>='              skip
RARROWEQUAL          <- '>='               skip
RBRACE               <- '}'                skip
RBRACKET             <- ']'                skip
RPAREN               <- ')'                skip
SEMICOLON            <- ';'                skip
SLASH                <- '/'      ![=]      skip
SLASHEQUAL           <- '/='               skip
TILDE                <- '~'                skip

end_of_word <- ![a-zA-Z0-9_] skip
KEYWORD_align       <- 'align'       end_of_word
KEYWORD_allowzero   <- 'allowzero'   end_of_word
KEYWORD_and         <- 'and'         end_of_word
KEYWORD_anyframe    <- 'anyframe'    end_of_word
KEYWORD_anytype     <- 'anytype'     end_of_word
KEYWORD_asm         <- 'asm'         end_of_word
KEYWORD_async       <- 'async'       end_of_word
KEYWORD_await       <- 'await'       end_of_word
KEYWORD_break       <- 'break'       end_of_word
KEYWORD_callconv    <- 'callconv'    end_of_word
KEYWORD_catch       <- 'catch'       end_of_word
KEYWORD_comptime    <- 'comptime'    end_of_word
KEYWORD_const       <- 'const'       end_of_word
KEYWORD_continue    <- 'continue'    end_of_word
KEYWORD_defer       <- 'defer'       end_of_word
KEYWORD_else        <- 'else'        end_of_word
KEYWORD_enum        <- 'enum'        end_of_word
KEYWORD_errdefer    <- 'errdefer'    end_of_word
KEYWORD_error       <- 'error'       end_of_word
KEYWORD_export      <- 'export'      end_of_word
KEYWORD_extern      <- 'extern'      end_of_word
KEYWORD_fn          <- 'fn'          end_of_word
KEYWORD_for         <- 'for'         end_of_word
KEYWORD_if          <- 'if'          end_of_word
KEYWORD_inline      <- 'inline'      end_of_word
KEYWORD_noalias     <- 'noalias'     end_of_word
KEYWORD_nosuspend   <- 'nosuspend'   end_of_word
KEYWORD_noinline    <- 'noinline'    end_of_word
KEYWORD_opaque      <- 'opaque'      end_of_word
KEYWORD_or          <- 'or'          end_of_word
KEYWORD_orelse      <- 'orelse'      end_of_word
KEYWORD_packed      <- 'packed'      end_of_word
KEYWORD_pub         <- 'pub'         end_of_word
KEYWORD_resume      <- 'resume'      end_of_word
KEYWORD_return      <- 'return'      end_of_word
KEYWORD_linksection <- 'linksection' end_of_word
KEYWORD_struct      <- 'struct'      end_of_word
KEYWORD_suspend     <- 'suspend'     end_of_word
KEYWORD_switch      <- 'switch'      end_of_word
KEYWORD_test        <- 'test'        end_of_word
KEYWORD_threadlocal <- 'threadlocal' end_of_word
KEYWORD_try         <- 'try'         end_of_word
KEYWORD_union       <- 'union'       end_of_word
KEYWORD_unreachable <- 'unreachable' end_of_word
KEYWORD_usingnamespace <- 'usingnamespace' end_of_word
KEYWORD_var         <- 'var'         end_of_word
KEYWORD_volatile    <- 'volatile'    end_of_word
KEYWORD_while       <- 'while'       end_of_word

keyword <- KEYWORD_align / KEYWORD_allowzero / KEYWORD_and / KEYWORD_anyframe
         / KEYWORD_anytype / KEYWORD_asm / KEYWORD_async / KEYWORD_await
         / KEYWORD_break / KEYWORD_callconv / KEYWORD_catch / KEYWORD_comptime
         / KEYWORD_const / KEYWORD_continue / KEYWORD_defer / KEYWORD_else
         / KEYWORD_enum / KEYWORD_errdefer / KEYWORD_error / KEYWORD_export
         / KEYWORD_extern / KEYWORD_fn / KEYWORD_for / KEYWORD_if
         / KEYWORD_inline / KEYWORD_noalias / KEYWORD_nosuspend / KEYWORD_noinline
         / KEYWORD_opaque / KEYWORD_or / KEYWORD_orelse / KEYWORD_packed
         / KEYWORD_pub / KEYWORD_resume / KEYWORD_return / KEYWORD_linksection
         / KEYWORD_struct / KEYWORD_suspend / KEYWORD_switch / KEYWORD_test
         / KEYWORD_threadlocal / KEYWORD_try / KEYWORD_union / KEYWORD_unreachable
         / KEYWORD_usingnamespace / KEYWORD_var / KEYWORD_volatile / KEYWORD_while
禅
意図を的確に伝える. 
エッジケースは重要である. 
コードを書くより, コードを読むことを優先する. 
明白な方法は 1 つだけ. 
ランタイムクラッシュはバグよりも優れている. 
コンパイルエラーはランタイムクラッシュより良い. 
ローカルな最大値を避ける
局所的な最大値を避ける. 
覚えなければならない量を減らす. 
スタイルよりもコードに重点を置く. 
リソースの割り当てに失敗しても, リソースの割り当て解除は成功しなければならない. 
メモリは資源である. 
一緒になってユーザーに奉仕する. 

これを実行すると, 2つの異なるアドレスが得られる. 
これは, levelUpで変更されているユーザーがmainのユーザーと異なることを意味する. これは, Zigが値のコピーを渡すために起こる. 
これは奇妙なデフォルトのように思えるかもしれないが, 関数の呼び出し側が, 関数がパラメータを変更しないことを確信できる（変更できないから）という利点がある. 多くの場合, これは保証されているに越したことはない. 

再入可能性（Reentrancy）: 同じ関数が再度呼び出される前に, その関数が引数を変更しないことを保証することは, 再入可能な関数を作成する際に重要です. 再入可能な関数は, 割り込みハンドラやマルチスレッド環境で特に重要です. 

スレッドセーフ: マルチスレッド環境では, 同じデータに対する同時アクセスを避けるために, 関数が引数を変更しないことを保証することが重要です. これにより, データ競合や不整合を防ぐことができます. 

関数の純粋性（Pure Functions）: 関数が引数を変更しないことを保証することは, 純粋な関数（同じ入力に対して常に同じ出力を返す関数）を作成する際に重要です. 純粋な関数は, テストやデバッグが容易で, 副作用がないため, 信頼性の高いコードを書く上で有用です. 

予期せぬ副作用の防止: 関数が引数を変更しないことを保証することで, 予期せぬ副作用を防ぐことができます. これは, コードの読みやすさと保守性を向上させます. 

これらのケースでは, 関数が引数を変更しないことを保証することが, コードの安全性, 信頼性, 読みやすさを向上させるために重要となります. 
user.power+=0;を使って強制的にuserを変異させるような醜いハックはもう必要ない. というのも, userはvarなのだが, コンパイラが変異させられないと教えてくれたからだ. 私たちはコンパイラが間違っていて, 変異を強制することでコンパイラを "騙した "のかもしれないと考えた. しかし, 今わかっているように, levelUpで変異させられているuserは別のもので, コンパイラーは正しかったのだ. 
 関数のパラメーターやメモリー・モデルにはまだ微妙な点がたくさんあるが, 前進はしている. この構文を除けば, どれもZig独自のものではないことを述べておく良い機会だろう. 私たちがここで探求しているモデルは最も一般的なものであり, 言語によっては開発者から多くの詳細, つまり柔軟性を隠してしまうかもしれない. 

定数関数パラメータ
デフォルトでは, Zigは値のコピーを渡す（"値渡し "と呼ばれる）ことを暗に示した. まもなく, 現実はもう少し微妙であることがわかるだろう（ヒント：ネストされたオブジェクトを持つ複雑な値については？）

単純な型にこだわっても, コードの意図が保たれることを保証できる限り, Zigは好きなようにパラメータを渡すことができるということだ. 私たちのオリジナルのlevelUpでは, パラメータがUserだったので, Zigは, 関数がUserを変異させないことを保証できる限り, Userのコピーを渡すことも, main.userへの参照を渡すこともできた. (しかし, User型にすることで, そうしないことをコンパイラに伝えたのだ）. 

この自由度によって, Zigはパラメータ型に基づいた最適な戦略を使うことができる. Userのような小さな型は, 値で渡す（つまりコピーする）ことで安く済ませることができる. より大きな型は参照渡しの方が安上がりかもしれない. Zigは, コードの意図が保たれる限り, どのようなアプローチでも使うことができる. これは, 関数のパラメータが一定であることによってある程度可能になる. 

これで, 関数パラメータが定数である理由の1つがわかっただろう. 

参照渡しをすることで, 本当に小さな構造体をコピーするのと比べても, どうして遅くなるのか不思議に思うかもしれない. しかし, 要は, userがポインターのときにuser.powerを実行すると, ほんの少しのオーバーヘッドが追加されるということだ. コンパイラーは, コピーのコストと, ポインターを介して間接的にフィールドにアクセスするコストを比較検討しなければならない. 


ポインタからポインタへ
levelUp内のuser変数が具体的な値を表していることを明示する価値はある. ポインタについて唯一特別なことは, user.powerのようにドット構文を使うと, userがポインタであることを知っているZigは, 自動的にアドレスを追いかけるということがわかるからだ. 
前回は, メイン関数内のuserのメモリがどのように見えるかを見てきた. levelUpを変更した今, そのメモリはどのように見えるだろうか？
levelUp内のuser変数が具体的な値を表していることを明示する価値はある. 
levelUp内では, user は User へのポインタです. その値はアドレスである. もちろん単なるアドレスではなく, main.userのアドレスです. 
この値はたまたまアドレスである. そして, 単なるアドレスではなく, *Userという型でもある. 変数がアドレスに型情報を関連付けるのだ. 
ポインタについて唯一特別なことは, user.powerのようにドット構文を使うと, userがポインタであることを知っているZigは, 自動的にアドレスを追いかけるということだ. 

理解すべき重要な点は, levelUpのユーザー変数自体が, あるアドレスのメモリー上に存在するということだ. 先ほどと同じように, これを自分自身で確認することができる：

上記は, user変数が参照するアドレスとその値を表示する. 
userが*Userの場合, &userは何でしょうか？これは**User, つまりUserへのポインタへのポインタだ. どちらかがメモリを使い果たすまで, こんなことができる！

複数レベルの間接処理を使うケースもあるが, 今すぐ必要なものではない. このセクションの目的は, ポインターは特別なものではなく, 単なる値であり, アドレスであり, 型であることを示すことです. 
理解すべき重要な点は, levelUpのユーザー変数自体が, あるアドレスのメモリー上に存在するということだ. 


## build.zigの説明
この関数は命令的に見えますが、その役割は外部のランナーによって実行されるビルドグラフを宣言的に構築することに注意してください。

標準的なターゲットオプションは、`zig build`を実行する人がビルドするターゲットを選択できるようにします。
ここではデフォルトを上書きせず、任意のターゲットが許可され、デフォルトはネイティブです。
他のオプションでサポートされるターゲットセットを制限することも可能です。

標準的な最適化オプションは、`zig build`を実行する人がDebug、ReleaseSafe、ReleaseFast、およびReleaseSmallの間で選択できるようにします。
優先的なリリースモードを設定せず、ユーザーがどのように最適化するかを決定できます。

この宣言は、ユーザーが"install"ステップを呼び出すとき（`zig build`を実行するときのデフォルトのステップ）、実行可能ファイルが標準の場所にインストールされる意図を示します。

これはビルドグラフにRunステップを*作成*します。
これは、それに依存する他のステップが評価されるときに実行されます。
次の行はそのような依存関係を確立します。

runステップをinstallステップに依存させることで、それはキャッシュディレクトリ内から直接実行されるのではなく、インストールディレクトリから実行されます。
これは必須ではありませんが、アプリケーションが他のインストールされたファイルに依存している場合、これによりそれらが存在し、予想される場所にあることが保証されます。

これにより、ユーザーはビルドコマンド自体でアプリケーションに引数を渡すことができます。
例えば、`zig build run -- arg1 arg2 etc`のようになります。

これはビルドステップを作成します。
これは`zig build --help`メニューに表示され、このように選択できます：`zig build run`
これにより、デフォルトの"install"ではなく、`run`ステップが評価されます。

ユニットテストのステップを作成します。
これはテスト実行可能ファイルのみをビルドしますが、実行はしません。

先にrunステップを作成したのと同様に、これは`test`ステップを`zig build --help`メニューに公開し、ユーザーがユニットテストの実行を要求する方法を提供します。

# Zig ビルドシステム
Zig Build System は, プロジェクトをビルドするために必要なロジックを宣言するための, クロスプラットフォームで依存性のない方法を提供します. このシステムでは, プロジェクトをビルドするためのロジックは build.zig ファイルに記述され, Zig Build System API を使ってビルドアーチファクトやその他のタスクを宣言し, 設定することができます. 

ビルドシステムが支援するタスクの例をいくつか挙げます. 

Zig コンパイラの実行によるビルドの成果物の作成. これには, C や C++のソースコードだけでなく, Zig のソースコードのビルドも含まれます. 
ユーザが設定したオプションを取得し, そのオプションを使用してビルドを設定する. 
Zig のコードからインポート可能なファイルを提供することで, ビルド構成を comptime の値として表面化させる. 
ビルド内容をキャッシュし, 不要なステップの繰り返しを回避します. 
ビルド・アーティファクトやシステムにインストールされたツールの実行
テストを実行し, ビルド・アーティファクトの実行による出力が期待値と一致することを確認する. 
コードベースまたはそのサブセットに対して zig fmt を実行する. 
カスタムタスク. 
ビルドシステムを使用するには, zig build --help を実行すると, コマンドライン使用法のヘルプメニューが表示されます. 
これには, build.zig スクリプトで宣言されたプロジェクト固有のオプションが含まれます. 


### Freestanding
Web ブラウザや nodejs のようなホスト環境では, 独立した OS ターゲットを使ってダイナミックライブラリとしてビルドします. WebAssembly にコンパイルされた Zig のコードを nodejs で実行する例を示します. 

### WASI
Zig の WebAssembly System Interface (WASI) のサポートは現在活発に開発中です. 標準ライブラリの使用とコマンドライン引数の読み込みの例. 

より興味深い例は, ランタイムからプレオープンのリストを抽出することです. これは現在標準ライブラリで std.fs.wasi.PreopenList を介してサポートされています. 

### Targets
Zig は, LLVM がサポートする全てのターゲットのコード生成をサポートしています. 以下は, Linux x86_64 コンピュータで zig ターゲットを実行したときの様子です. 

Zig 標準ライブラリ (@import("std")) は, アーキテクチャ, 環境, オペレーティングシステムを 抽象化しているため, より多くのプラットフォームをサポートするために追加作業が必要になります. しかし, すべての標準ライブラリのコードがオペレーティングシステムの抽象化を必要とするわけではないので, 汎用データ構造のようなものは上記のすべてのプラットフォームで動作します. 

現在, Zig 標準ライブラリがサポートしているターゲットの一覧は以下の通りです. 
Linux x86_64 Windows x86_64 macOS x86_64

## ビルドスクリプトを読んでみる
https://zenn.dev/drumato/books/learn-zig-to-be-a-beginner/viewer/build#%E3%83%93%E3%83%AB%E3%83%89%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%92%E8%AA%AD%E3%82%93%E3%81%A7%E3%81%BF%E3%82%8B
build.zigファイルはzig build 時に参照されるビルドスクリプトで, この機能のおかげで、ZigではMakefileを用意する必要がありません。
主に、Cライブラリをリンクしたりする際に詳しく利用することになります。

#### zig build で zig build test が呼ばれるようにする
ビルドする前に、テストがすべて通ることを確認したい場合があると思います。
その時にはbuild.zigを改変することで、ビルド時にzig build testが呼ばれるようにすることができます。
このようにい変更することで、src/main.zigに、std.testing.expect(false); のようなテストブロックを追加してみると、zig build が失敗し、実行ファイルが生成されないことがわかります。

大まかにビルドスクリプトからわかることは、zig build の挙動と、 zig build testのようなステップをそれぞれ定義して、ステップごとに記述する方式であることです。
STEPとしては例えば、 exe.setBuildMode(mode); と、 exe_tests.setBuildMode(mode); で異なるビルドモードを指定することもできます。

このビルドスクリプトを見ると、テスト対象として src/main.zig のみ追加されているように見えます。
実際、 src/main.zig で src/a.zig の関数を呼んでいたとしても、 zig build test では src/a.zigで定義されたテストは実行されません。
ここで、Zigでよく使われるテクニックを利用することで、src/main.zigが参照している他の定義をテスト対象に追加することができます。