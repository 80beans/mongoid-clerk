module Clerk::Logger
  extend ActiveSupport::Concern

  module ClassMethods

    def default_fields
      @default_fields ||=
        if superclass.respond_to?(:default_fields)
          superclass.default_fields.dup
        else
          {}
        end
    end

    def clerk_always_include(*new_default_fields)
      new_default_fields.each do |default_field|
        default_field = { default_field => default_field } unless default_field.is_a?(Hash)
        Clerk::Log.send(:field, default_field.values.first)
        default_fields.merge!(default_field)
      end
    end

  end

  def log(msg, level = :info)
    Clerk::Log.create!(
      included_fields.merge(
        :message => msg,
        :level => level
      )
    )
  end

  def included_fields
    {}.tap do |return_hash|
      self.class.default_fields.each do |source_field, target_field|
        return_hash[target_field.to_sym] = read_attribute(source_field.to_sym)
      end
    end
  end

  included do
    has_many :log_items, :as => :logable, :class_name => 'Clerk::Log'
  end
end

#### usage
#
# class InputStream
#   include Clerk::Logger
#
#   clerk_always_include :id => :input_stream_id, :company_id
#
#   def something
#     log('Something went wrong!', :error)
#   end
#
# end
#
