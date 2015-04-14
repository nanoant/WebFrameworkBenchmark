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
[go]: http://golang.org/pkg/net/http/
[onion]: https://github.com/davidmoreno/onion
[cowboy]: http://ninenines.eu/docs/en/cowboy/1.0/guide/getting_started/
[nim]: http://nim-lang.org
[puma]: http://puma.io
[echo]: http://wiki.nginx.org/HttpEchoModule
[resty]: http://openresty.org
[iron]: http://ironframework.io
[pull]: https://github.com/Araq/Nim/pull/2244

|  Language    |        Framework        | Req/sec<sup>1</sup> | MB/sec |
| ------------ | ---------------------------------- | --------:| ------:|
| Java         | [Undertow][undertow]               |  74 040  |        |
| Nim *M&S/PR*<sup>2</sup> | [AsyncHTTPServer][nim] |  67 330  |        |
| Native/C     | [Nginx][echo]<sup>3</sup>          |  63 724  |        |
| Java         | [Netty][netty]                     |  61 148  |        |
| Go           | [net/http][go]                     |  60 714  |        |
| C            | [Onion][onion]<sup>4</sup>         |  60 613  |        |
| Lua          | [OpenResty][resty]<sup>5</sup>     |  47 370  |        |
| Nim *PR*<sup>6</sup>     | [AsyncHTTPServer][nim] |  47 258  |        |
| Rust         | [Iron][iron]                       |  46 869  |        |
| Nim *M&S*<sup>7</sup>    | [AsyncHTTPServer][nim] |  43 798  |        |
| Erlang       | [Cowboy][cowboy]                   |  30 822  |  2.97  |
| Nim<sup>8</sup>          | [AsyncHTTPServer][nim] |  28 994  |        |
| Ruby         | [Puma][puma]<sup>9</sup>           |  24 539  |        |

<sup>1</sup> *OSX 10.10.3*, *Intel Core i5-2400S* 2.50GHz, 16 GB RAM  
<sup>2</sup> *Nim* patched with [following pull request][pull],
             using `--gc:markandsweep`, single-thread only.  
<sup>3</sup> Using `echo` module.  
<sup>4</sup> Running `hello` example with `static` path.  
<sup>5</sup> *OpenResty* is in fact *Nginx* with *Lua* module.  
<sup>6</sup> *Nim* patched with [following pull request][pull],
             default RC GC, single-thread only.  
<sup>7</sup> *Nim* standard implementation,
             using `--gc:markandsweep`, single-thread only.  
<sup>8</sup> *Nim* standard implementation,
             default RC GC, single-thread only.  
<sup>9</sup> Using several *Ruby* instances with `puma -w 4`.  


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
