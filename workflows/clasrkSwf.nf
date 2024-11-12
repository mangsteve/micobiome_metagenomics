include { doClarkS } from '../modules/doClarkS'

workflow CLARK_S_WORKFLOW {
    take:
    ch_fastq_paired
    clark_tool
    clark_targets
    db_dir

    main:
    doClarkS(
        clark_tool,
        clark_targets,
        db_dir,
        ch_fastq_paired
    )
    ch_clark_s_output = doClarkS.out

    emit:
    ch_clark_s_output
}
