include { doClark } from '../modules/clark'

workflow CLARK_WORKFLOW {
    take:
    ch_fastq_paired
    

    main:
    doClark(
        params.doClark.clark_tool,
        params.doClark.clark_targets, 
        params.doClark.db_dir,
        ch_fastq_paired
    )
    ch_clark_output = doClark.out
    .view{ "CLARK output: $it" }

    emit:
    ch_clark_output
}

