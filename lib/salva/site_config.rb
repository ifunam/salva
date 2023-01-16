module Salva
  module SiteConfig
    protected
    def self.method_missing(method, *args, &block)
      # if configuration(method).is_a? Hash and configuration(method).has_key? args.first.to_s
        configuration(method)[args.first.to_s]
      # else
      #   raise "Section #{method} undefined"
      # end
    end

    private
    def self.load_config(file_name)
      file_path = "#{Rails.root.to_s}/config/#{file_name}"
      YAML.load_file(file_path)
    end

    def self.configuration(section)
      load_config('site.yml')[section.to_s]
    end
  end
end
