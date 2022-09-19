from setuptools import setup

from Cython.Build import cythonize

setup(ext_modules=cythonize("PyOMP.pyx", language_level=3))