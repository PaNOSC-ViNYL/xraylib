import os
from shutil import which
from subprocess import run as sub_run
from distutils.command.build import build
from setuptools import setup, Extension, find_packages
try:
    import numpy
except ImportError:
    raise Exception("Numpy is required to build xraylib")
try:
    from Cython.Build import cythonize
except ImportError:
    raise Exception("Cython is required to build xraylib")

here = os.path.abspath(os.path.dirname(__name__))

def check_dependencies():
    '''
    Check dependencies for Windows (msbuild) and Unix (make).
    :raises Exception: if one is missing, an exception is raised.
    '''
    if not which("make"):
        raise Exception("You need to install make in order to execute the makefile to build SRW")

class XRayLibBuild(build):
    def run(self):
        check_dependencies()
        sub_run(['autoreconf', '-i'])
        sub_run(['sh', '{}/configure'.format(here)])
        sub_run(['make', '-C', here])
        super().run()

extensions = [Extension('np_xraylib', ['python/xraylib_np.pyx',
                                       'src/xrayvars.c',
                                       'src/cross_sections.c',
                                       'src/scattering.c',
                                       'src/atomicweight.c',
                                       'src/edges.c',
                                       'src/fluor_lines.c',
                                       'src/fluor_yield.c',
                                       'src/jump.c',
                                       'src/coskron.c',
                                       'src/radrate.c',
                                       'src/cs_line.c',
                                       'src/polarized.c',
                                       'src/splint.c',
                                       'src/cs_barns.c',
                                       'src/fi.c',
                                       'src/fii.c',
                                       'src/kissel_pe.c',
                                       'src/xrayfiles_inline.c',
                                       'src/xraylib-aux.c',
                                       'src/xraylib-error.c',
                                       'src/xraylib-parser.c',
                                       'src/cs_cp.c',
                                       'src/refractive_indices.c',
                                       'src/comptonprofiles.c',
                                       'src/atomiclevelwidth.c',
                                       'src/auger_trans.c',
                                       'src/xrf_cross_sections_aux.c',
                                       'src/crystal_diffraction.c',
                                       'src/xraylib-nist-compounds.c',
                                       'src/densities.c',
                                       'src/xraylib-radionuclides.c',
                                       'src/xrayglob_inline.c'],
                                       include_dirs=['{}/include'.format(here),
                                                     '.'])]


setup(name='xraylib',
      version='3.1',
      author="Tom Schoonjans",
      py_modules=["xraylib"],
      packages=find_packages(),
      ext_modules=cythonize(extensions),
      cmdclass={'build': XRayLibBuild})
