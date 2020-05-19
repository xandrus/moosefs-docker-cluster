#!/usr/bin/env bash

# Create basic MooseFS config

mkdir -p data/cs{1..4}/{"hdd0","metadata","config"}
mkdir -p data/master/{"metadata","config"}

# MooseFS master bootstrap
if [ ! -f data/master/metadata/metadata.mfs ];
then
	echo "MFSM NEW" > data/master/metadata/metadata.mfs
fi

if [ ! -f data/master/config/mfsexports.cfg ];
then
	echo -e '# Allow everything except meta resource
* / rw,alldirs,admin,maproot=0:0\n
# Allow meta resurce
* . rw' > data/master/config/mfsexports.cfg
fi

if [ ! -f data/master/config/mfsmaster.cfg ];
then
	echo "SYSLOG_IDENT = mfsmaster_docker" > data/master/config/mfsmaster.cfg
fi

# MooseFS chunk server bootstrap
for i in $(find data/ -name cs*);
do
	if [ ! -f ${i}/config/mfshdd.cfg ];
	then
		echo "/mnt/hdd0" > ${i}/config/mfshdd.cfg
	fi
done

echo "LABELS = M" > data/cs1/config/mfschunkserver.cfg
echo "LABELS = M, B" > data/cs2/config/mfschunkserver.cfg
echo "LABELS = M, B" > data/cs3/config/mfschunkserver.cfg
echo "LABELS = B" > data/cs4/config/mfschunkserver.cfg

# Fix folder ownership for Linux
echo "Fix ownership for data folder"
if [ "$(uname)" == "Linux" ];
then
	sudo chown -R 101:101 data
fi
