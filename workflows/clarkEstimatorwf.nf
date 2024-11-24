include { estimateClark } from '../modules/clarkEstimator'

workflow CLARK_AND_CLARKS_ESTIMATION {
    take:
        val estimator_tool
        path db_dir
        path clark_results_dir
        path clarks_results_dir

    main:
       
        clark_channel = Channel
            .fromPath("${clark_results_dir}/*.csv")
            .map { file -> [file.baseName, file] }

        
        clarks_channel = Channel
            .fromPath("${clarks_results_dir}/*.csv")
            .map { file -> [file.baseName, file] }

        
        grouped_clark_and_clarks = clark_channel
            .concat(clarks_channel)
            .groupTuple(by: 0) 
            .map { sample_id, files ->
                def clark_results = files.find { it.getName().contains('Clark') }
                def clarks_results = files.find { it.getName().contains('Clark_S') }
                [sample_id, clark_results, clarks_results]
            }

        ch_estimation_results = estimateClark(
            estimator_tool,
            db_dir,
            grouped_clark_and_clarks
        )

    emit:
        ch_estimation_results
}
