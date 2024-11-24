process estimateClark {
    label 'mg23_clark_estimator'
    conda params.doClark.conda
    cpus params.resources.doClark.cpus
    memory params.resources.doClark.mem
    queue params.resources.doClark.queue
    clusterOptions params.resources.doClark.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5
    publishDir "$results_dir/mg23_clark", mode: 'symlink'

    input:
    val estimator_tool            
    path db_dir           
    tuple(val(sample_id), path(clark_results), path(clarks_results)) 

    output:
    tuple(val(sample_id), path("clark_estimated_*.csv"), path("clarks_estimated_*.csv"))

    script:
    """
    clark_output_file=clark_estimated_!{sample_id}.csv
    clarks_output_file=clarks_estimated_!{sample_id}.csv

  
    !{estimator_tool} \
        -F !{clark_results}
        -D !{db_dir} \
       

    !{estimator_tool} \
        -F !{clarks_results}
        -D !{db_dir} \
    """
}