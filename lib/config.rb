require 'yaml'

module Game
  class Config
    def self.load(type)
      path = File.join(ROOT_PATH, "config/#{type}.yml")
      YAML.load File.read(path)
    end
  end
end
