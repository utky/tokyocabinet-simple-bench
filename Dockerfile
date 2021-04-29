FROM centos:8

RUN yum -y install dnf-plugins-core \
  && yum config-manager --set-enabled powertools \
  && yum groupinstall -y 'Development Tools' \
  && yum install -y tokyocabinet ruby ruby-devel zlib-devel bzip2-devel java-1.8.0-openjdk-devel \
  && yum install --enablerepo powertools -y tokyocabinet-devel \
  && gem install tokyocabinet -v 1.32.0

RUN mkdir -p /app
COPY bench.c /app
COPY bench.rb /app
COPY Bench.java /app
WORKDIR /app
RUN gcc bench.c -ltokyocabinet -o bench
RUN curl -LO https://dbmx.net/tokyocabinet/javapkg/tokyocabinet-java-1.24.tar.gz \
  && tar xzf tokyocabinet-java-1.24.tar.gz 
RUN sh -c "cd /app/tokyocabinet-java-1.24; env MYJAVAHOME=/usr/lib/jvm/java ./configure && make && make install"
RUN javac -cp /usr/local/lib/tokyocabinet.jar Bench.java
COPY entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
