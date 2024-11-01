workflow MASH {
    take:
    ch_fastq_paired  // Asegúrate de que este canal está correctamente poblado desde el proceso anterior o desde el input inicial.

    main:
    // Ejecutar el proceso Mash para generar los sketches
    doMash(ch_fastq_paired)
    ch_mash_output = doMash.out  // Este canal debe contener archivos .msh si ajustaste el proceso doMash.

    emit:
    ch_mash_output  // Emitir el resultado para que otros procesos lo utilicen.
}
