import tokyocabinet.HDB;
class Bench {
    public static void main(String[] args) {
        HDB hdb = new HDB();
        hdb.open(args[0], HDB.OCREAT | HDB.OWRITER);
        for (int i = 0; i < 10000000; i++) {
            if (!hdb.put(String.valueOf(i), String.valueOf(i))) {
                System.err.printf("error on putting %d", i);
            }
        }
        hdb.close();
    }
}
