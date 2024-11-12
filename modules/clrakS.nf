process doClarkS {
    label 'mg21_clark_s'
    conda params.doClarkS.conda
    cpus params.resources.doClarkS.cpus
    memory params.resources.doClarkS.mem
    queue params.resources.doClarkS.queue
    clusterOptions params.resources.doClarkS.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5
    publishDir "$results_dir/mg19_clark_s", mode: 'symlink'

    input:
    val clark_tool        
    val clark_targets     
    path db_dir           
    tuple(val(sample_id), path(fastq_paired))  

    output:
    tuple(val(sample_id), path("results_*.csv"))

    script:
    """
    output_file=results_!{sample_id}.csv

    # Ejecutar CLARK-S con discriminativos espaciales
    !{clark_tool} \
        -k 10 \
        -T !{clark_targets} \
        -t 1 \
        -D !{db_dir} \
        -P !{fastq_paired[0]} !{fastq_paired[1]} \
        -o 0 \
        -R $output_file \
        --spaced \
        -n !{task.cpus}
    """
}
