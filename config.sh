export SMRT_ROOT=/net/eichler/vol24/projects/sequencing/pacbio/software/smrtanalysis

# Use modules to load dependencies if that environment is available.
if [[ ! -z `which module` ]]
then
    module load bedtools/2.23.0
    module load blasr/dev
    module load freebayes/0.9.14
    module load samtools/1.1

    module load hdf5/1.8.13
    module load netcdf/4.3.2
    module load R/3.1.0
    module load perl/5.14.2
    module load RepeatMasker/3.3.0

    module load mpc/0.8.2 gmp/5.0.2 gcc/4.9.1
else
    export ANACONDA_ROOT=$HOME/anaconda
    export PATH=$ANACONDA_ROOT/envs/python2/bin:$ANACONDA_ROOT/envs/python3/bin:$PATH
fi
