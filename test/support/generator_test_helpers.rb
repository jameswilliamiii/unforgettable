module GeneratorTestHelpers
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def create_generator_sample_app
      FileUtils.cd(BASE_DIR) do
        system "rails new tmp --skip-test-unit --skip-spring --skip-bundle --skip-bootsnap --skip-listen --quiet"
      end
    end

    def remove_generator_sample_app
      FileUtils.rm_rf(TMP_APP_LOCATION)
    end
  end
end