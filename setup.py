from setuptools import setup
from pathlib import Path
from Cython.Build import cythonize

setup(ext_modules=cythonize("PyOMP.pyx", language_level=3))

current_directory = Path(__file__).parent
pyd_file = list(current_directory.glob('*.pyd'))[0]
pyd_file.replace(current_directory / 'pyomp' / f"{pyd_file.stem.split('.')[0]}.pyd")
