process doClarkS {
    label 'mg21_clark_s'
    conda params.doClarkS.conda
    cpus params.resources.doClarkS.cpus
    memory params.resources.doClarkS.mem
    queue params.resources.doClarkS.queue
    clusterOptions params.resources.doClarkS.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5
    publishDir "$results_dir/mg21_clark_s", mode: 'symlink'

    input:
    tuple(val(sample_id), path(fastq_file))  // Archivos de entrada de CLARK-S (paired-end o single-end)

    output:
    path "${sample_id}_clark_s_result.csv"

    script:
    """
    # Ejecutar CLARK-S para clasificar metagenomas
    ./classify_metagenome.sh -O !{fastq_file} -R ${sample_id}_clark_s_result.csv --spaced
    """
}