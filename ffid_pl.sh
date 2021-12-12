#!/bin/bash

# Command line version of our OpenMS pipeline
# run en parralel pour tous les samples possibly

#SBATCH --time=03:00:00
#SBATCH --mem=11G
#SBATCH --account=def-emmar


PeakPickerHiRes 
-in \
-out \
-mslevel 1

MSGFPlusAdapter \
 -in \
 -out \
 -executable \
 -database \
 -instrument 'high-res' \
 -enzyme 'Chymotrypsin/P' \
 -max_mods 7 \
 -variable_modifications 'Oxidation (M)' 'Acetyl (K)' 'Acetyl (Protein N-term)' 'Propionyl (K)' \
 -java_memory 10000 

PeptideIndexer \
 -in \
 -fasta \
 -out \
 -decoy_string 'XXX_' \
 -missing_decoy_action 'warn' \
 -allow_unmatched true \
 -aaa_max 4 

PSMFeatureExtractor \
 -in \
 -out

PercolatorAdapter \
 -in \
 -out \
 -peptide_level_fdrs true \
 -protein_level_fdrs true \
 -threads 6

IDFilter \
-in \
-out \
-remove_decoys true \
-score:pep 0.01 

MapAlignerIdentification \
 -in \
 -out \

IDMerger \
 -in \
 -out \

FeatureFinderIdentification \
 -in \
 -out \

ProteinQuantifier \
 -in \
 -out \
