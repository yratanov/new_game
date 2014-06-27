require 'yaml'
require 'level_object/bomb'
require 'level_object/health'
require 'level_object/creature/zombie'
require 'hud/debug'

module Game
  class Config
    def self.configurable_classes
      [
        Player,
        LevelObject::Health,
        LevelObject::Bomb,
        LevelObject::Creature::Zombie,
        Hud::Debug,
      ]
    end

    def self.set_up
      configurable_classes.each do |klass|
        configure_class klass
      end
    end

    def self.configure_class(klass)
      settings = load(underscore(klass))
      settings.each do |key, value|
        klass.send("#{key}=", value)
      end
    end

    def self.load(type)
      begin
        path = File.join(ROOT_PATH, "config/#{type}.yml")
        YAML.load File.read(path)
      rescue
        {}
      end
    end

    def self.underscore(klass)
      klass.to_s.gsub(/([a-z])([A-Z])/, "\\1_\\2").
        downcase.gsub('::', '/')
    end
  end
end
