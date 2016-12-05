#!/bin/bash
#set -x
set -e


export NOW=$(date +%Y%m%d%H%M%S)
export THIS=$(basename $0)
export RUNAS=$(whoami)
export WHEREAMI=$(dirname $0)
export LOG_DIR=/var/tmp
export PROC=$$
export LOG_ID=${PROC}
export HOSTNAME=$(hostname)
export OUTPUT_DIR=~/results
export SNAPSHOT=$(( ($(date +%-m)-1)/3+1 ))Q$(date +%Y)



if [ -z "$1" ]
then
		echo "repo needs to be set e.g ${THIS} epel"
		exit 1

else
	export REPO=$1
	if  yum repoinfo ${REPO} |grep Repo-status
	then
		echo "attempting to mirror ${REPO} as snapshot ${SNAPSHOT}"
	else
		echo "repo ${REPO} doesnt look like its enabled. Cannot mirror..."
		exit 1
	fi
fi	

BASEDIR=/mirrors/${SNAPSHOT}/${REPO}
mkdir -p $BASEDIR
cd $BASEDIR

#Sync the repo pulling only the newest pacakages
reposync -n -r ${REPO}
#Clean out any old rpms
repomanage -o -c ${REPO} | xargs rm -fv
#Create the yum repo metadata
createrepo ${REPO}
