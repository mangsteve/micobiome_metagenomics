process doMashKallistoPipeline {
    label 'mg21_mash_kallisto_pipeline'
    conda params.doMashKallistoPipeline.conda
    cpus params.resources.doMashKallistoPipeline.cpus
    memory params.resources.doMashKallistoPipeline.mem
    queue params.resources.doMashKallistoPipeline.queue
    clusterOptions params.resources.doMashKallistoPipeline.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 10
    publishDir "$results_dir/mg20_mash_kallisto_pipeline", mode: 'symlink'

    input:
        path mash_output
        val(top_strains)
        tuple(val(illumina_id), path(fastq_paired))

    output:
        path 'mash_kallisto_output/*'

    script:
    """
    mkdir -p mash_kallisto_output
    python3 mash_kallisto_pipeline.py !{mash_output} !{top_strains} \
        --directory mash_kallisto_output \
        --reads1 !{fastq_paired[0]} \
        --reads2 !{fastq_paired[1]}
    """
}
