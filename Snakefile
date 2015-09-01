"""
Structural variant caller for PacBio reads.

See also: https://github.com/EichlerLab/pacbio_variant_caller
"""
import math
import os

#
# Define internal constants.
#
BLASR_BIN = "/net/eichler/vol20/projects/pacbio/nobackups/users/jlhudd/blasr_jlhudd/alignment/bin/blasr"
CWD = os.getcwd()

#
# Load user variables.
#
configfile: "config.json"
TMP_DIR = config["tmp_dir"]
EVENT_TYPES = ("insertion", "deletion")

CHROMOSOME_LENGTHS = config.get("reference_index", "%s.fai" % config["reference"])

#
# Include rules.
#

# TODO: fix bug caused by Snakemake not understanding more than one dynamic
# output type per file.
include: "rules/prepare_reference.rules"
include: "rules/alignment.rules"
include: "rules/sv_candidates.rules"
include: "rules/local_assembly.mhap_celera.rules"
include: "rules/variant_caller.rules"

#
# Determine which outputs to create.
#

OUTPUTS = []

if config.get("detection"):
    OUTPUTS.extend([
        "sv_candidate_lengths.pdf",
        "sv_candidate_support.pdf",
        "assembly_candidates.bed"
    ])

# if config.get("assembly") and config["assembly"].get("regions_to_assemble"):
#     OUTPUTS.append("sv_assemblies.txt")

# if config.get("gap_extension") and config["gap_extension"].get("regions_to_assemble"):
#     OUTPUTS.append("gap_assemblies.txt")

#
# Define rules.
#

# Create list of all final outputs.
rule all:
    input: OUTPUTS
