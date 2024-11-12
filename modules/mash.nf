process doMash {
    label 'mg20_mash'
    conda params.doMash.conda
    cpus params.resources.doMash.cpus
    memory params.resources.doMash.mem
    queue params.resources.doMash.queue
    clusterOptions params.resources.doMash.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5

    input:
    path reference_sketch 
    tuple(val(illumina_id), path(fastq_paired)) 

    output:
    ///tupla y nombre del archivo
    ///aqui tenemos que coger el dist
    path 'mash_output.msh'

    script:
    """
    # Crear sketch de las lecturas
    mash sketch -o sample_sketch !{fastq_paired[0]} !{fastq_paired[1]}

    # Ejecutar Mash para comparar las lecturas contra el sketch de referencia
    mash dist !{reference_sketch} sample_sketch.msh > mash_output.dist
    """
}
