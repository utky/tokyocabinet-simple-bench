require 'tokyocabinet'
include TokyoCabinet

hdb = HDB::new
# open the database
if !hdb.open(ARGV[0], HDB::OWRITER | HDB::OCREAT)
  ecode = hdb.ecode
  STDERR.printf("open error: %s\n", hdb.errmsg(ecode))
end
(0..10000000).each do |i|
  if !hdb.put(i.to_s, i.to_s)
    ecode = bdb.ecode
    STDERR.printf("put error: %s\n", bdb.errmsg(ecode))
  end
end
hdb.close
