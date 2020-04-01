#!/bin/bash

d=`date +%Y-%m-%d`
partition=$1
j_name=$2
resource=$3
cmd=$4
hdd=/scratch/hdd001/home/$USER
ssd=/scratch/ssd001/home/$USER
j_dir=$ssd/slurm/$d/$j_name

mkdir -p $j_dir/scripts

# build slurm script
mkdir -p $j_dir/log
echo "#!/bin/bash
#SBATCH --job-name=${j_name}
#SBATCH --output=${j_dir}/log/%j.out
#SBATCH --error=${j_dir}/log/%j.err
#SBATCH --partition=${partition}
#SBATCH --cpus-per-task=$[4 * $resource]
#SBATCH --ntasks-per-node=1
#SBATCH --mem=$[22*$resource]G
#SBATCH --gres=gpu:${resource}
#SBATCH --nodes=1

bash ${j_dir}/scripts/${j_name}.sh
" > $j_dir/scripts/${j_name}.slrm

# build bash script
echo -n "#!/bin/bash
ln -s /checkpoint/$USER/\$SLURM_JOB_ID ${j_dir}/\$SLURM_JOB_ID
touch ${j_dir}/\$SLURM_JOB_ID/DELAYPURGE
$cmd
" > $j_dir/scripts/${j_name}.sh

sbatch $j_dir/scripts/${j_name}.slrm --qos normal
