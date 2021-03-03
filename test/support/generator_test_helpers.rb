module GeneratorTestHelpers
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def test_path
      File.join(File.dirname(__FILE__), "..")
    end

    def create_generator_sample_app
      FileUtils.cd(test_path) do
        system "rails new tmp --skip-test-unit --skip-spring --skip-bundle --skip-bootsnap --skip-listen --quiet"
      end
    end

    def remove_generator_sample_app
      FileUtils.rm_rf(destination_root)
    end
  end
end