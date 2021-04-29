#!/bin/bash -x
time ./bench test_c.tch
time ruby bench.rb test_ruby.tch
time java -server -Djava.library.path=/usr/local/lib -cp .:/usr/local/lib/tokyocabinet.jar Bench test_java.tch
