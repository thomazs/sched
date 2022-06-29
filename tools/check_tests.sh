#!/bin/sh

echo ""
echo "===================================================================================="
echo "Checking coverage for Python code"
echo ""

COV_THRESHOLD=70;
SOURCE_DIR=.
pytest tests --cov=$SOURCE_DIR --showlocals --cov-report= ;
ERROR=$?;

COV_REPORT=`coverage report -m`;
coverage=`echo "$COV_REPORT" | grep 'TOTAL' | sed 's/TOTAL\s*\w*\s*\w*//g' | cut -d'%' -f1`;

echo 'coverage was:' $coverage'%'

if [ "$ERROR" != "0" ]
then
    if [ $coverage -lt $COV_THRESHOLD ]
    then
	echo "But something went wrong";
	exit 1
    else
	echo "And something went wrong"
	exit 1
    fi
fi

if [ $coverage -ge $COV_THRESHOLD ]
then
    echo "Yay! Everything ok!";
    if [ $coverage -lt 100 ]
    then 
        echo ""
        echo '===================================================================================='
        echo "Coverage was greather or equal than expected! Coverage: $coverage%  - Expected: $COV_THRESHOLD%";
        echo "But have any parts to cover"
        echo '===================================================================================='
        coverage report -m
    fi
    exit 0;
else
    echo ""
    echo '************************************************************************************'
    echo "Coverage lower then expected! Coverage: $coverage%  - Expected: $COV_THRESHOLD%";
    echo '************************************************************************************'
    coverage report -m
    exit 1
fi
