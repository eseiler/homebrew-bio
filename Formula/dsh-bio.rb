class DshBio < Formula
  desc "Tools for BED, FASTA, FASTQ, GAF, GFA1/2, GFF3, PAF, SAM, and VCF files"
  homepage "https://github.com/heuermh/dishevelled-bio"
  url "https://search.maven.org/remotecontent?filepath=org/dishevelled/dsh-bio-tools/2.0.4/dsh-bio-tools-2.0.4-bin.tar.gz"
  sha256 "d7ac4e83cda8eceb4503abc046afb488d55a22b8229d7a37e63c0d57897baeb7"
  license "LGPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/brewsci/bio"
    sha256 cellar: :any_skip_relocation, catalina:     "7caa13a0436a8bd41402c2d2a11ccbbc1c5536725a1642332070b08228114d46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad8da45ac7ac2ba804c1505676b54bf6e042c841d68f87d28cf3720eb17d21f8"
  end

  depends_on "openjdk"

  def install
    rm Dir["bin/*.bat"] # Remove all windows files
    libexec.install Dir["*"]
    Dir["#{libexec}/bin/*"].each do |exe|
      name = File.basename(exe)
      (bin/name).write <<~EOS
        #!/bin/bash
        export JAVA_HOME="${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
        exec "#{exe}" "$@"
      EOS
    end
  end

  test do
    assert_match "usage", shell_output("#{bin}/dsh-bio --help")
  end
end
