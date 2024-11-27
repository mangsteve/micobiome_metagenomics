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
    path clark_tool        
    path clark_targets     
    path db_dir           
    tuple(val(sample_id), path(fastq_paired))  

    output:
    tuple(val("CLARK"), val(sample_id), path("*_CLARK.raw.csv"))

    shell:
    '''
    output_file=!{sample_id}_CLARK.raw.csv

    # Ejecutar CLARK
    !{clark_tool} \
        -k 10 \
        -T !{clark_targets} \
        -t 1 \
        -D !{db_dir} \
        -P !{fastq_paired[0]} !{fastq_paired[1]} \
        -o 0 \
        -n !{task.cpus}
    '''

    stub:
    """
    touch $sample_id'_CLARK.raw.csv'
    """
}
