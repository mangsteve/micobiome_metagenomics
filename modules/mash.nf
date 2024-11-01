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
    path "*.msh"  // Cambio a formato .msh

    script:
    """
    # Ejecutar Mash para crear un sketch de los archivos FASTQ
    mash sketch -o ${illumina_id}.msh -m 2 !{fastq_paired[0]} !{fastq_paired[1]}
    # Información del sketch para verificación
    mash info ${illumina_id}.msh
    """
}

