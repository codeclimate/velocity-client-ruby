module Velocity
  class Base < OpenStruct
    class NotFoundError < StandardError; end

    class << self
      attr_reader :resource_class_name

      def resource_class(class_name = nil)
        @resource_class_name ||= class_name
      end
    end

    def initialize(args)
      super(args.deep_transform_keys {|key| key.to_s.underscore })
    end

    def self.create(args)
      data = resource_class.new(args).create
      new(data["attributes"].merge(id: data["id"]))
    end

    def self.all
      resource_class.new({}).fetch.map do |data|
        new(data["attributes"].merge(id: data["id"]))
      end
    end

    def self.where(args)
      resource_class.new(args).fetch.map do |data|
        new(data["attributes"].merge(id: data["id"]))
      end
    end

    def self.find_by(args)
      where(args).first
    end

    def self.find_by!(args)
      where(args).first or raise NotFoundError, "record not found with #{args.inspect}"
    end

    def update(args)
      data = self.class.resource_class.new(args.merge(id: self.id)).update
      self.class.new(data["attributes"].merge(id: data["id"]))
    end
  end
end
