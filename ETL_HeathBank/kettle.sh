#!/bin/bash

#set kettle project path
basepath=$(cd `dirname $0`; pwd)
kettle_path="/opt/pdi-ce-5.4.0.1-130/data-integration"

mkdir -p "${basepath}/log"

if [ $# -eq 1 ]
then
    date -d $1 "+%Y-%m-%d" | grep -q $1
    if [ $? -eq 1 ]
    then
        echo "输入参数应为合法日期<yyyy-mm-dd>"
        exit 1
    else
        # 通过的日期即为符合格式的合法日期
        etldate=$1
    fi
else
    etldate=`date "+%Y-%m-%d"`
    echo "没有输入日期参数，取当前日期: $etldate"
fi



##go to kettle soft dir
cd $kettle_path
./kitchen.sh -file=${basepath}/HBCL_STAT_DAILY_SLEEP.kjb  -level=basic -param:etl_dt=${etldate} >>${basepath}/log/kettle_${etldate}.log
