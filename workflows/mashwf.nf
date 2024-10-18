workflow MASH {
    take:
    ch_fastq_paired

    main:
    // Ejecutar el proceso Mash para generar los sketches
    doMash(ch_fastq_paired)
    ch_mash_output = doMash.out

    emit:
    ch_mash_output
}
