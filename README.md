# zap-dlang: ZAP for D

> **Docs:** [ZAP D SDK](https://zap-proto.dev/docs/sdks) · part of the [ZAP Protocol](https://zap-proto.io)


ZAP is an extremely efficient protocol for sharing data
and capabilities, and zap-dlang is a pure D implementation.

# State

* Passes ZAP testsuite.
* A little slower/faster than the official C++ implementation (see [benchmarks](#benchmarks)).
* Missing RPC part of ZAP.
* Missing JSON codec (workaround: zap tool can convert to and from JSON).
* Missing ZAP toString format (workaround: zap tool can convert to and from text format).

# Schema compilation
Build the dlang plugin for the ZAP compiler.

```bash
make
```

Run the ZAP compiler to generate the D interface code for your schema.

```bash
zapc -odlang example.zap
```

Or

```bash
zapc -o/path/to/zapc-dlang example.zap
```

Depending on whether the dlang plugin is installed to path.

# Use in code

```D
import example;
import zap;

void main()
{
    auto message = new MessageBuilder(); //From zap.
    auto rootObject = message.initRoot!AnyObject; //AnyObject from example.
    //Do stuff with rootObject.
    //Use Serialize or SerializePacked to get the serialized message.
}
```

## Sample

A full example including pregenerated D code from schema is available [here](https://github.com/zap-proto/d/tree/master/source/samples).

```bash
dub build -c sample-addressbook
[zap-dlang]$ ./addressbook write | ./addressbook read
Alice: alice@example.com
  mobile phone: 555-1212
  student at: MIT
Bob: bob@example.com
  home phone: 555-4567
  work phone: 555-7654
  unemployed
```

# <a name="benchmarks"></a>Benchmarks

Benchmarked on Skylake i7. Best of three runs.

```bash
dub build -c benchmark-carsales --compiler ldc --build=release

[zap-dlang]$ time ./benchmark-carsales object 0 none 20000
real    0m0,538s
user    0m0,527s
sys     0m0,010s

[zap-c++]$ time ./zap-carsales object no-reuse none 20000
real    0m0,410s
user    0m0,406s
sys     0m0,001s

[zap-c++]$ time ./zap-carsales object reuse none 20000
real    0m0,350s
user    0m0,346s
sys     0m0,002s

dub build -c benchmark-catrank --compiler ldc --build=release

[zap-dlang]$ time ./benchmark-catrank object 0 none 20000
real    0m10,999s
user    0m10,977s
sys     0m0,004s

[zap-c++]$ time ./zap-catrank object no-reuse none 20000
real    0m11,259s
user    0m10,789s
sys     0m0,422s

[zap-c++]$ time ./zap-catrank object reuse none 20000
real    0m10,287s
user    0m10,251s
sys     0m0,003s

dub build -c benchmark-eval --compiler ldc --build=release

[zap-dlang]$ time ./benchmark-eval object 0 none 20000
real    0m0,109s
user    0m0,105s
sys     0m0,004s

[zap-c++]$ time ./zap-eval object no-reuse none 20000
real    0m0,191s
user    0m0,189s
sys     0m0,002s

[zap-c++]$ time ./zap-eval object reuse none 20000
real    0m0,185s
user    0m0,183s
sys     0m0,001s

```