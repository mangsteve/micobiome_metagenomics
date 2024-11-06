workflow CLARK_S {
    take: ch_fastq_paired

    main:
    doClarkS(ch_fastq_paired)

    emit:
    doClarkS.out
}