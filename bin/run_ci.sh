#!/bin/sh


if [ ! -d "reports" ]; then
    mkdir reports
fi

if [ ! -d "venv" ]; then
    virtualenv venv
    . venv/bin/activate
    PATH=$PATH:/usr/pgsql-9.2/bin
    pip install -r test_project/requirements.txt
    deactivate
    cd venv/lib/python*/site-packages
    ln -s ../../../../ps_django_inmemorystorage
    cd ../../../../
    # or run `python setup.py develop`

fi

if [ ! -f "/opt/sqlite3/ps_django_inmemorystorage.db" ]; then
    touch /opt/sqlite3/ps_django_inmemorystorage.db
fi

. venv/bin/activate
PATH=$PATH:/usr/pgsql-9.2/bin pip install -r test_project/requirements.txt

mkdir -p reports
pylint --rcfile=.pylintrc ps_django_inmemorystorage 2>&1 > reports/pylint.txt || echo
./test_project/manage.py test -v3 --with-xcoverage --noinput --xcoverage-file=reports/coverage.xml --with-xunit
TESTS_PASSED=$?   # 0 if passed > 0 if not, so we can return as an exit code

exit $TESTS_PASSED
