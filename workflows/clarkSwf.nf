include { doClarkS } from '../modules/clarkS'

workflow CLARK_S_WORKFLOW {
    take:
    ch_fastq_paired

    main:
    doClarkS(
        params.doClarkS.clark_tool,
        params.doClarkS.clark_targets,
        params.doClarkS.db_dir,
        params.doClarkS.spaced_option,
        ch_fastq_paired
    )
    ch_clark_s_output = doClarkS.out
    .view{ "CLARKS output: $it" }

    emit:
    ch_clark_s_output
}
