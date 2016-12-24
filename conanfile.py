from conans import ConanFile
from conans.tools import download, untargz
import os

class TypeSafe(ConanFile):
    name = 'type_safe'
    url  = 'https://foonathan.github.io/blog/2016/10/11/type-safe.html'
    version = '0.1'
    username = 'Manu343726'
    channel = 'testing'
    requires = 'debug_assert/1.0@Manu343726/testing'
    exports = '*.hpp'
    generators = 'cmake'


    def source(self):
        tar = 'type_safe-{}.tar.gz'.format(self.version)
        url = 'https://github.com/foonathan/type_safe/archive/v{}.tar.gz'.format(self.version)
        download(url, tar)
        untargz(tar)

    def package(self):
        includedir = os.path.join('include', 'type_safe')
        srcdir = os.path.join('type_safe-{}'.format(self.version), includedir)
        self.copy('*.hpp', src=srcdir, dst=includedir)
