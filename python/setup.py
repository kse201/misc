from setuptools import setup
import os

def strip_comments(l):
    return l.split('#', 1)[0].strip()

def reqs(*f):
    return list(filter(None, [strip_comments(l) for l in open(
        os.path.join(os.getcwd(), *f)).readlines()]))

setup(
    name="mypackage",
    install_requires=reqs('requirements.txt'),
    entry_points= {
        "console_scripts": [
            "client = mypackage.cmd.client:main"
        ]
    }
)