
#download /genomes/.vol3/archive/old_refseq/Bacteria/all.gbk.tar.gz
# Uncompress only some

bash install_slam_new_db.sh kslam_virus  viruses

SLAM --parse-taxonomy taxonomy/names.dmp taxonomy/nodes.dmp
SLAM --output-file database1 --parse-genbank bacteria2/*/*.gbk

SLAM --db=/home/carmoma/projects/TFM_MiguelAngelEsteve/test_software/k-SLAM/kslam_virus/ --output-file=test_db1 /home/carmoma/projects/TFM_MiguelAngelEsteve/test_data/testA_1.fastq.gz /home/carmoma/projects/TFM_MiguelAngelEsteve/test_data/testA_2.fastq.gz


