include { estimateClark } from '../modules/clark_estimator'

workflow CLARK_AND_CLARKS_ESTIMATION {
     
    take:
        clark_results
        clarks_results
    
    main:

        //clark_results = clark_results.map { [it[0], it[1], it[2]]}
        //clarks_results = clarks_results.map { [it[0], it[1], it[2]] }

        grouped_clark = clark_results
            .concat(clarks_results)
            .view{"Grouped Clark: $it"}

        estimateClark(
           grouped_clark
           
       )
        ch_estimation_results = estimateClark.out
        .view{"clark_estimate result: $it"}

    emit:
       ch_estimation_results
}
