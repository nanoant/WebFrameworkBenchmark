Web Frameworks Benchmark
------------------------
[techempower]: https://www.techempower.com/benchmarks/

The idea behind this benchmark is to re-evaluate results presented by
[Techempower's Benchmark][techempower] benchmarking best & promising
open-source frameworks.


### Why another benchmark?

I just found [Techempower's Benchmark][techempower] sources overcomplicated.
Also wanted to test only framework overhead, that's why testing just trivial
dynamic `Hello World` world output.

Just to not raise a controversy, I want also to emphasize this benchmark is
simple & native and completely skips some unique features of some frameworks
and languages, such as Erlang's natural clustering and hot-swap capabilities.


### Results

[undertow]: http://undertow.io
[netty]: http://netty.io
[node]: https://nodejs.org/api/cluster.html
[go]: http://golang.org/pkg/net/http/
[onion]: https://github.com/davidmoreno/onion
[cowboy]: http://ninenines.eu/docs/en/cowboy/1.0/guide/getting_started/
[nim]: http://nim-lang.org
[puma]: http://puma.io
[echo]: http://wiki.nginx.org/HttpEchoModule
[resty]: http://openresty.org
[iron]: http://ironframework.io
[jester]: https://github.com/dom96/jester
[vibed]: http://vibed.org
[dmd]: https://dlang.org/download.html
[crow]: https://github.com/ipkn/crow
[kore]: https://kore.io
[mhttpd]: https://www.gnu.org/software/libmicrohttpd/
[fasthttp]: https://github.com/valyala/fasthttp

|  Language     |        Framework       | Req/sec<sup>1| MB/sec| 99% ms<sup>2|
| ------------- | ------------------------ | ----------:| -----:| -----------:|
| Java          | [Undertow][undertow]     |   616 547  | 80.55 |      3.29   |
| C             | [libmicrohttpd][mhttpd]  |   533 626  | 69.72 |      1.28   |
| C             | [Kore][kore]       <sup>3|   513 184  | 93.48 |      4.09   |
| C             | [Onion][onion]     <sup>4|   483 824  | 90.90 |      2.82   |
| Go            | [fasthttp][fasthttp]     |   433 424  | 60.35 |      3.12   |
| Java          | [Netty][netty]           |   422 580  | 40.30 |      4.08   |
| Native        | [Nginx][echo]      <sup>5|   381 368  | 43.26 |     24.24   |
| Nim m&s <sup>6| [AsyncHTTPServer][nim]   |   350 511  | 38.11 |     12.82   |
| Go            | [net/http][go]           |   270 253  | 34.28 |      2.52   |
| Lua           | [OpenResty][resty] <sup>7|   269 205  | 30.28 |     43.35   |
| C++           | [Crow][crow]             |   256 552  | 31.32 |     12.28   |
| Rust          | [Iron][iron]             |   178 789  | 19.44 |  0.05 <sup>8|
| Erlang        | [Cowboy][cowboy]   <sup>9|   163 521  | 24.01 |      5.41   |
| Node          | [HTTP][node]             |   112 086  | 13.79 |     11.98   |
| Nim m&s<sup>10| [AsyncHTTPServer][nim]   |    86 741  |  9.43 |      1.40   |
| Nim m&s<sup>10| [Jester][nim]     <sup>11|    83 753  |  5.99 |      1.50   |
| Ruby          | [Puma][puma]      <sup>12|    83 053  |  6.02 |      6.14   |
| D ldc2 <sup>13| [Vibe.d][vibed] <sub>0.7.26|  79 602  | 13.28 |     46.41   |
| D dmd  <sup>14| [Vibe.d][vibed] <sub>0.7.26|  76 839  | 12.75 |    103.05   |
| Nim    <sup>15| [AsyncHTTPServer][nim]   |    52 843  |  5.75 |      4.76   |
| Nim    <sup>15| [Jester][jester]         |    42 698  |  3.05 |      5.42   |

<sup>1</sup> *Ubuntu 14.04 LTS*, *Linux 3.16*,
             *Xeon E5-1650* @ 3.50GHz, 32 GB RAM  
<sup>2</sup> Latency distribution value at 99% in milliseconds
             (towards worst)  

<sup>3</sup> *Core* built without SSL via using `make NOTLS=1`.  
<sup>4</sup> Running `hello` example with `static` path.  
<sup>5</sup> Using *Nginx* `echo` module.  
<sup>6</sup> *Nim* using `--gc:markandsweep`, pre-forked processes
             using `SO_REUSEPORT`.  
<sup>7</sup> *OpenResty* is in fact *Nginx* with *Lua* module.  
<sup>8</sup> *Rust* *Iron* has some amazing super-stable latency
             in longer runs.  
<sup>9</sup> *Cowboy* requires some low level tweaking via `sysctl`, see
             and apply [`sysctl.conf`](sysctl.conf).  
<sup>10</sup> *Nim* using `--gc:markandsweep`, single-thread only.  
<sup>11</sup> *Jester* is some higher-level web framework for Nim.  
<sup>12</sup> Using several *Ruby* instances with `puma -w 12`.  
<sup>13</sup> *D* language using [LDC2](dmd) compiler v0.16.1 (LLVM 3.7.0).  
<sup>14</sup> *D* language using standard [DMD](dmd) compiler v2.069.1.  
<sup>15</sup> *Nim* using standard RC garbage collection, single-thread only.  

**NOTE**: Detailed results can be found in [`results/`](results).


### Benchmarking details

Each web framework is expected to respond with `Hello World` content of type
`text/plain` with minimum set of headers required by HTTP 1.1 specification:

~~~
$ curl -i localhost:8080
HTTP/1.1 200 OK
Connection: Keep-Alive
Content-Length: 11
Content-Type: text/plain
Date: Tue, 24 Nov 2015 17:32:30 GMT

Hello World
~~~

Some frameworks add extra headers such as `Server` or `Expire` by default,
which are not required by HTTP 1.1 specification. If possible we use some
settings or tweaks to remove them as more headers (so more data) will have
negative impact on performance.

Effectively this benchmark tests solely the framework overhead itself. We are
**not** testing any database access or JSON serialization performance. We are
also avoiding some extra optimizations, such as caching response memory
structures which could improve performance a bit, but contradicts dynamic
behavior of tested frameworks.


### Conclusions

As expected *Java* solutions outperform any other. 2nd & 3rd places are
occupied by native C frameworks - *libmicrohttpd* and *Onion*, which are very
interesting solutions if you want to create small web apps with minimal
dependencies.

One should also notice *Nim* performance, which compares to *Node* & *Ruby*,
but runs only on single core! (1 of 12). *Nim* and its async HTTP server module
are very young projects, and multi-threaded version is already in plans. It has
great potential to be next no. 1 in next iteration of this benchmark.

It has to be also observed that different frameworks generated different amount
of data due different HTTP headers being used.


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
