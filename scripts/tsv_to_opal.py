import pandas as pd
import os

def process_bracken_files_to_opal(input_dir, output_dir):
    """
    Processes all Bracken files (genus, phylum, species) from a directory
    and generates OPAL-compatible files for each sample.

    Args:
        input_dir (str): Directory containing the Bracken files.
        output_dir (str): Directory to save the reformatted OPAL-compatible files.
    """
    os.makedirs(output_dir, exist_ok=True)

    
    sample_files = {}
    for file_name in os.listdir(input_dir):
        if file_name.endswith(".bracken.report.txt"):
            sample_name = file_name.split(".")[0] 
            if sample_name not in sample_files:
                sample_files[sample_name] = []
            sample_files[sample_name].append(file_name)

    for sample_name, files in sample_files.items():
        combined_data = []

        for file_name in files:
           
            rank = "unknown"
            if "species" in file_name:
                rank = "species"
            elif "genus" in file_name:
                rank = "genus"
            elif "phylum" in file_name:
                rank = "phylum"

            file_path = os.path.join(input_dir, file_name)

           
            data = pd.read_csv(file_path, sep="\t", header=None, 
                               names=["Percentage", "Reads", "Taxon_Reads", "Rank", "TaxID", "TaxPath"])

            
            formatted_data = pd.DataFrame({
                "@@TAXID": data["TaxID"],
                "RANK": rank,
                "TAXPATH": data["TaxPath"],
                "TAXPATHSN": data["TaxPath"],
                "PERCENTAGE": data["Percentage"],
                "_CAMI_genomeID": "",
                "_CAMI_OTU": ""
            })

            combined_data.append(formatted_data)

        
        if combined_data:
            final_data = pd.concat(combined_data)

           
            header = (
                "# Taxonomic Profiling Output\n"
                "@SampleID:1\n"
                "@Version:0.9.3\n"
                "@Ranks:superkingdom|phylum|class|order|family|genus|species|strain\n"
                "@TaxonomyID:cami-ncbi-taxonomy_2015.01.30\n\n"
            )

            
            output_file = os.path.join(output_dir, f"{sample_name}_opal.tsv")
            with open(output_file, 'w') as f:
                f.write(header)
            final_data.to_csv(output_file, sep="\t", index=False, mode='a')

if __name__ == "__main__":
    
    input_directory = "."  
    output_directory = "./opal_formatted_files"  

    process_bracken_files_to_opal(input_directory, output_directory)
    print(f"Processed files saved in {output_directory}")