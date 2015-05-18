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

|  Language     |        Framework         | Req/sec[^1]| MB/sec| 99% ms[^2]|
| ------------- | ------------------------ | ----------:| -----:| ---------:|
| Java          | [Undertow][undertow]     |   616 547  | 80.55 |      3.29 |
| C             | [Onion][onion]       [^3]|   483 824  | 90.90 |      2.82 |
| Java          | [Netty][netty]           |   422 580  | 40.30 |      4.08 |
| Native        | [Nginx][echo]        [^4]|   381 368  | 43.26 |     24.24 |
| Go            | [net/http][go]           |   270 253  | 34.28 |      2.52 |
| Lua           | [OpenResty][resty]   [^5]|   269 205  | 30.28 |     43.35 |
| Rust          | [Iron][iron]             |   178 789  | 19.44 |[^6]  0.05 |
| Erlang        | [Cowboy][cowboy]         |   146 185  | 14.07 |      5.81 |
| Node          | [HTTP][node]             |   112 086  | 13.79 |     11.98 |
| Nim m&s   [^7]| [AsyncHTTPServer][nim]   |   101 963  |  7.29 |      1.33 |
| Nim m&s   [^7]| [Jester][nim]        [^8]|    83 753  |  5.99 |      1.50 |
| Ruby          | [Puma][puma]         [^9]|    83 053  |  6.02 |      6.14 |
| Nim      [^10]| [AsyncHTTPServer][nim]   |    69 962  |  5.00 |      4.71 |
| Nim      [^10]| [Jester][jester]         |    42 698  |  3.05 |      5.42 |

[^1]: *Ubuntu 14.04 LTS*, *Linux 3.16*, *Xeon E5-1650* @ 3.50GHz, 32 GB RAM  
[^2]: latency distribution value at 99% in milliseconds (towards worst)  
  
[^3]: Running `hello` example with `static` path.  
[^4]: Using *Nginx* `echo` module.  
[^5]: *OpenResty* is in fact *Nginx* with *Lua* module.  
[^6]: *Rust* *Iron* has some amazing super-stable latency in longer runs.  
[^7]: *Nim* using `--gc:markandsweep`, single-thread only.  
[^8]: *Jester* is some higher-level web framework for Nim.  
[^9]: Using several *Ruby* instances with `puma -w 12`.  
[^10]: *Nim* using standard RC garbage collection, single-thread only.  

**NOTE**: Detailed results can be found in [`results/`](results).

### Conclusions

As expected *Java* solutions outperform any other.

*Nim* however comes in 2nd place - showing its great potential as an ultimate
web framework solution, due its amazing compile-time term rewriting
capabilities and mixed GC and normal stack allocation.

It has to be also emphasized that current *Nim* implementation is
single-threaded, while *Java* solutions are multi-threaded.

It has to be also observed that different frameworks generated different amount
of data due different HTTP headers being used. Tuning headers could possibly
change the performance numbers slightly.

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
