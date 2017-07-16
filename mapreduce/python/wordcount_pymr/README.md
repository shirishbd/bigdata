
## Testing Locally
```
cat wordcounts_input.txt | python wmapper.py | sort | python wreducer.py
```

## Launching mapreduce job

Link the Hadoop-streaming jar:
```
ln -sf /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.6.0-mr1-cdh5.10.0.jar
```

Make sure the data file is on HDFS:
```
hadoop fs -copyFromLocal wordcounts_input.txt data/wordcounts_input.txt
```

Launch the MR job:
```
hadoop jar hadoop-streaming-2.6.0-mr1-cdh5.10.0.jar \
-input data/wordcounts_input.txt \
-output out/wordcounts_output \
-mapper wmapper.py \
-reducer wreducer.py \
-file wmapper.py \
-file wreducer.py
```

Inspect the output:
```
hadoop fs -copyToLocal out/wordcounts_output 
cd wordcounts_output/
```

