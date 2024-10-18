process doMash {
    label 'mg20_mash'
    conda params.doMash.conda  // Entorno Conda para Mash
    cpus params.resources.doMash.cpus
    memory params.resources.doMash.mem
    queue params.resources.doMash.queue
    clusterOptions params.resources.doMash.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5

    input:
    tuple(val(illumina_id), path(fastq_paired))

    output:
    path 'mash_output.txt'

    script:
    """
    # Ejecutar Mash
    mash sketch -o mash_output.txt !{fastq_paired[0]} !{fastq_paired[1]}
    """
}
