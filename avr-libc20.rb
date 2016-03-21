require 'formula'

class AvrLibc20 < Formula

    url 'http://download.savannah.gnu.org/releases/avr-libc/avr-libc-2.0.0.tar.bz2'
    homepage 'http://www.nongnu.org/avr-libc/'
    sha256 ''

    depends_on 'avr-gcc53'

    def install
        ENV.delete 'CFLAGS'
        ENV.delete 'CXXFLAGS'
        ENV.delete 'LD'
        ENV.delete 'CC'
        ENV.delete 'CXX'

        avr_gcc = Formula['avr-gcc53']

        build = `./config.guess`.chomp

        system "./configure", "--build=#{build}", "--prefix=#{prefix}", "--host=avr"
        system "make install"

        avr = File.join prefix, 'avr'

        # copy include and lib files where avr-gcc searches for them
        # this wouldn't be necessary with a standard prefix
        ohai "copying #{avr} -> #{avr_gcc.prefix}"
        cp_r avr, avr_gcc.prefix

    end
end
