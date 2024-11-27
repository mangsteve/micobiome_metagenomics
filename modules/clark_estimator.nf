process estimateClark {
    label 'mg23_clark_estimator'
    conda params.doClark.conda
    cpus params.resources.doClark.cpus
    memory params.resources.doClark.mem
    queue params.resources.doClark.queue
    clusterOptions params.resources.doClark.clusterOptions
    errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
    maxRetries 5
    publishDir "$results_dir/mgestimated_clark", mode: 'symlink'

    input:        
    tuple(val(program_id), val(sample_id), path(read_assignment)) 

    output:
    tuple(val(program_id), val(sample_id), path("*_estimated.csv"))

    shell:
    '''
    clark_output_file= aaa_bbb_estimated.csv
  
    !{params.estimateClark.clark_tool} \
        -F !{read_assignment}\
        -D !{params.estimateClark.db_dir} 
       

    '''

    stub:
    """
    touch $sample_id'_'$program_id'_estimated.csv'
    """
}