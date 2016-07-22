class Phpenv < Formula
  desc "PHP multi-version installation and management for humans."
  homepage "https://github.com/kadaan/phpenv"
  url "https://github.com/kadaan/phpenv.git", :tag => "0.0.4"
  version "0.0.4"
  head "https://github.com/kadaan/phpenv.git"

  bottle :unneeded

  def install
    inreplace "libexec/phpenv", "/usr/local", HOMEBREW_PREFIX
    prefix.install Dir["*"]
    %w[phpenv-install phpenv-uninstall php-build].each do |cmd|
      bin.install_symlink "#{prefix}/plugins/php-build/bin/#{cmd}"
    end
  end

  def caveats; <<-EOS.undent
    To use Homebrew's directories rather than ~/.phpenv add to your profile:
      export PHPENV_ROOT=#{var}/phpenv
    To enable shims and autocompletion add to your profile:
      if which phpenv > /dev/null; then eval "$(phpenv init -)"; fi
    EOS
  end

  test do
    shell_output("eval \"$(#{bin}/phpenv init -)\" && phpenv versions")
  end
end
