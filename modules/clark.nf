process doClark {
    label 'mg19_clark'
    conda params.doClark.conda
    cpus params.resources.doClark.cpus
    memory params.resources.doClark.mem
    queue params.resources.doClark.queue
    clusterOptions params.resources.doClark.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5
    publishDir "$results_dir/mg19_clark", mode: 'symlink'

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

    # Ejecutar CLARK
    !{clark_tool} \
        -k 10 \
        -T !{clark_targets} \
        -t 1 \
        -D !{db_dir} \
        -P !{fastq_paired[0]} !{fastq_paired[1]} \
        -o 0 \
        -R $output_file \
        -n !{task.cpus}
    """
}
