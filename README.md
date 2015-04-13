Web Frameworks Benchmark
------------------------
[techempower]: https://www.techempower.com/benchmarks/

The idea behind this benchmark is to re-evaluate results presented by
[Techempower's Benchmark][techempower] benchmarking best & promising
open-source frameworks.


### Why another benchmark?

I just found [Techempower's Benchmark][techempower] sources overcomplicated.
Also wanted to test only framework overhead, that's why testing `Hello World`.


### Results

[1]: http://undertow.io
[2]: http://netty.io
[3]: http://golang.org/pkg/net/http/
[4]: https://github.com/davidmoreno/onion
[5]: http://nim-lang.org

[openresty]: http://openresty.org

|  Language  |       Framework       | Req/sec[^1] |  MBytes   |
| ---------- | --------------------- | -----------:| --------: |
| Java       | [Undertow][1]         |      74'040 |  96.73 MB |
| Java       | [Netty][2]            |      61'148 |  58.31 MB |
| Go         | [net/http][3]         |      60'714 |  77.01 MB |
| C          | [Onion][4][^1]        |      60'613 |  77.01 MB |
| Nim        | [AsyncHTTPServer][5]  |      28'994 |  13.82 MB |


[^1]: Ran on *OSX 10.10.3* and *Intel Core i5-2400S* 2.50GHz, 16 GB RAM.
[^2]: Running `hello` example with `static` path.


### License

This benchmark is provided under MIT license:

> Copyright (c) 2015 Adam Strzelecki
>
> Permission is hereby granted, free of charge, to any person obtaining
> a copy of this software and associated documentation files (the
> "Software"), to deal in the Software without restriction, including
> without limitation the rights to use, copy, modify, merge, publish,
> distribute, sublicense, and/or sell copies of the Software, and to
> permit persons to whom the Software is furnished to do so, subject to
> the following conditions:
> 
> The above copyright notice and this permission notice shall be
> included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
> LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
> OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
> WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
