process CentrifugerMakeFileList{
  label 'mg20_centrifuger_filelist'
  conda params.CentrifugerMakeFileList.conda
  cpus params.resources.CentrifugerMakeFileList.cpus
  memory params.resources.CentrifugerMakeFileList.mem
  queue params.resources.CentrifugerMakeFileList.queue
  //array params.resources.array_size
  clusterOptions params.resources.CentrifugerMakeFileList.clusterOptions
  errorStrategy { task.exitStatus in 1..2 ? 'retry' : 'ignore' }
  maxRetries 10
  publishDir "$results_dir/mg20_centrifuger_filelist", mode: 'symlink'
  input:
    tuple(val(ref_name), path(ref_directory), path(seqid2taxid))

  output:
    tuple(val(ref_name), path("*_file_list.txt"), path("*_seqid2taxid2.map"))
  
  script:
  if(ref_name == params.CentrifugerMakeFileList.merges_dbs_name)
  """
 touch cfgrAll1_file_list.txt cfgrAll1_seqid2taxid2.map
  for p in library2 library1 library3 library4; do
      find "\$PWD/\$p/" -maxdepth 2 -type f -name "*.fna.gz" >> cfgrAll1_file_list.txt
      cat "\$p"_seqid2taxid.map >> cfgrAll1_seqid2taxid2.map
  done
  """
  else
  """
  ls -1 -d "\$PWD/"$ref_directory/*/*.fna.gz > $ref_name'_file_list.txt'
  mv $seqid2taxid $ref_name'_seqid2taxid2.map'

  """
  }