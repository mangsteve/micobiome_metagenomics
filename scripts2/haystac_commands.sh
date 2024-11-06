#https://github.com/antonisdim/haystac

conda activate haystac-env
haystac database \
    --mode build \
    --query '"Yersinia"[Organism] AND "complete genome"[All Fields]' \
    --output yersinia_db

haystac database \
    --mode build \
    --refseq-rep prokaryote_rep \
    --output refseq_db

haystac sample \
    --sra ERR1018966 \
    --output ERR1018966

haystac sample \
    --fastq-r1 /path/to/sample1_R1.fq.gz \
    --fastq-r2 /path/to/sample1_R2.fq.gz \
    --collapse True \
    --output sample1