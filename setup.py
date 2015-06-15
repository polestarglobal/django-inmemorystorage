#!/usr/bin/env python
import os
import ConfigParser
from setuptools import setup


def load_metadata(ini_file):
    config = ConfigParser.ConfigParser()
    read_files = config.read(ini_file)
    if len(read_files) == 0:
        raise Exception("Failed to read %s" % ini_file)
    meta = {}
    for item in config.options("meta"):
        meta[item] = config.get("meta", item)
    return meta


METADATA_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                             'ps_django_inmemorystorage/METADATA')
META = load_metadata(METADATA_PATH)


def read(fname):
    try:
        return open(os.path.join(os.path.dirname(__file__), fname)).read()
    except:
        return ""


setup(
    name=META["name"],
    version=META["version"],
    author='Cody Soyland',
    author_email="francesco.devirgilio@polestarglobal.com",
    description=META["description"],
    keywords="ps_django_inmemorystorage inmemory storage",
    packages=['ps_django_inmemorystorage'],
    include_package_data=True,
    package_data={'ps_django_inmemorystorage': ['METADATA']},
    long_description=read('README.rst')
)
