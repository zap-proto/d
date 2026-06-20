@0xd693321951fee8f3;

using Dlang = import "/zap/dlang.zap";
$Dlang.module("zap.tests.testimport");

using import "test.zap".TestAllTypes;

struct Foo {
	importedStruct @0 :TestAllTypes;
}
