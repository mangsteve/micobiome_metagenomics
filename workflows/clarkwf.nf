include { doClark } from '../modules/doClark'

workflow CLARK_WORKFLOW {
    take:
    ch_fastq_paired
    clark_tool
    clark_targets
    db_dir

    main:
    doClark(
        clark_tool,
        clark_targets,
        db_dir,
        ch_fastq_paired
    )
    ch_clark_output = doClark.out

    emit:
    ch_clark_output
}

