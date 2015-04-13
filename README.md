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

[undertow]: http://undertow.io
[netty]: http://netty.io
[go]: http://golang.org/pkg/net/http/
[onion]: https://github.com/davidmoreno/onion
[cowboy]: http://ninenines.eu/docs/en/cowboy/1.0/guide/getting_started/
[nim]: http://nim-lang.org
[puma]: http://puma.io
[echo]: http://wiki.nginx.org/HttpEchoModule
[resty]: http://openresty.org
[iron]: http://ironframework.io
[pull]: https://github.com/Araq/Nim/pull/2244

|  Language  |        Framework          | Req/sec<sup>1</sup> |   MBytes     |
| ---------- | ---------------------------------- | ----------:| ------------:|
| Java       | [Undertow][undertow]               |    74 040  |   96.73  MB  |
| Native/C   | [Nginx][echo]<sup>2</sup>          |    63 724  |  110.57  MB  |
| Java       | [Netty][netty]                     |    61 148  |   58.31  MB  |
| Go         | [net/http][go]                     |    60 714  |   76.91  MB  |
| C          | [Onion][onion]<sup>3</sup>         |    60 613  |   77.01  MB  |
| Nim *patched*<sup>4</sup>|[AsyncHTTPServer][nim]|    50 531  |   24.10  MB  |
| Lua        | [OpenResty][resty]<sup>5</sup>     |    47 370  |   81.56  MB  |
| Rust       | [Iron][iron]                       |    46 869  |   50.76  MB  |
| Erlang     | [Cowboy][cowboy]                   |    29 246  |   43.22  MB  |
| Nim        | [AsyncHTTPServer][nim]<sup>6</sup> |    28 994  |   13.82  MB  |
| Ruby       | [Puma][puma]<sup>7</sup>           |    24 539  |   17.79  MB  |

<sup>1</sup> *OSX 10.10.3*, *Intel Core i5-2400S* 2.50GHz, 16 GB RAM  
<sup>2</sup> Using `echo` module.  
<sup>3</sup> Running `hello` example with `static` path.  
<sup>4</sup> patched version of *Nim* with [following pull request][pull].  
<sup>5</sup> *OpenResty* is in fact *Nginx* with *Lua* module.  
<sup>6</sup> *Nim*'s current implementation is single-thread only.  
<sup>7</sup> Using several *Ruby* instances with `puma -w 4`.  


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
