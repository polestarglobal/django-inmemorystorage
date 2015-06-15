#!/bin/sh


if [ ! -d "reports" ]; then
    mkdir reports
fi

if [ ! -d "venv" ]; then
    virtualenv venv
    . venv/bin/activate
    PATH=$PATH:/usr/pgsql-9.2/bin
    pip install -r requirements.txt
    deactivate
    cd venv/lib/python*/site-packages
    ln -s ../../../../ps_django_inmemorystorage
    cd ../../../../

fi

. venv/bin/activate
PATH=$PATH:/usr/pgsql-9.2/bin pip install -r requirements.txt

mkdir -p reports
pylint --rcfile=.pylintrc ps_django_inmemorystorage 2>&1 > reports/pylint.txt || echo
TESTS_PASSED=0   # 0 if passed > 0 if not, so we can return as an exit code

exit $TESTS_PASSED
