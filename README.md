# TokyocabinetのLangurange Bindingを比較してみる

[CrystalとCを比較しているリポジトリがあったので](https://github.com/maiha/tokyocabinet.cr#benchmark)同様のコードでRubyとJavaを比べてみることにした。

現在仕事ではRubyのバインディングを使っているのだけれどせっかくHadoop/YARNの分散システムがあるのでそこを活用して並列でtchを作る仕組みにそろそろ乗り換えたくなった。

## 動かし方

build image
```
$ docker build -t bench:latest .
```
run benchmark
```
% docker run -it --rm bench
+ ./bench test_c.tch

real    0m23.970s
user    0m7.002s
sys     0m15.429s
+ ruby bench.rb test_ruby.tch

real    0m54.063s
user    0m23.006s
sys     0m25.706s
+ java -server -Djava.library.path=/usr/local/lib -cp .:/usr/local/lib/tokyocabinet.jar Bench test_java.tch

real    0m47.897s
user    0m17.156s
sys     0m25.694s
```

ランタイムが起動する分のペナルティやFFI呼ぶところのオーバヘッドなどを考えるとまあそうなるかなという感じ。もう少しJavaなら行けるのではないかと期待したがそうでもなかった。`String.valueOf`のオーバヘッドとかはあるかも知れない。

JavaよりRubyの方が速いというのをどこかで見かけた気がするけどどういう検証だったのか気になる。
