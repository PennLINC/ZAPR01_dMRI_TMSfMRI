cd $TMPDIR
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`
export SINGULARITY_LOCALCACHEDIR=`pwd`

/share/apps/singularity/2.5.1/bin/singularity build qsiprep-0.6.3RC3.simg docker://pennbbl/qsiprep:0.6.3RC3
mv qsiprep-0.6.3RC1.simg /data/jac/cnds/applications/qsiprep


