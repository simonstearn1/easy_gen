require 'fileutils'

module GeneratorTestHelper

  def dest_dir
    File.expand_path("./dummy", File.dirname(__FILE__))
  end

  def easy_gen_ensure(abs_path)
    FileUtils.mkdir_p File.dirname(File.absolute_path(abs_path))
    FileUtils.touch(abs_path) unless File.exist?(abs_path)
  end

end
