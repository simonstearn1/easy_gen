require 'pathname'

module EasyGen
  class EasyGenRailtie < Rails::Railtie

    initializer "easy_gen_railtie.configure_generators" do

      generator_dirs = Pathname(File.dirname(__dir__) + '/easy_gen/').children.select(&:directory?)


      @@generator_files = []
      generator_dirs.each do | dir |
        @@generator_files << Dir["#{dir}/*_generator.rb"]
      end
      @@generator_files.flatten!

    end

    generators do
      @@generator_files.each do | file |
        require file
      end
    end
  end
end
