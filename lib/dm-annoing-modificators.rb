require 'dm-core'
require 'pp'

module DataMapper
  module RaiseSaveFailure
    def self.format_errors(errors)
      message = []
      errors.map do |errors|
        errors.each do |error|
          message << "#{error.attribute_name}: #{error.rule.class} - #{error.message}"
        end
      end
      message.empty? ? ' -- NONE --' : message.join("\n")
    end

    def raise_save_failure(resource,operation,context=:default)
      if resource.respond_to? :valid?
        resource.valid? context
      end
      if resource.respond_to? :errors
        additional = "\nerrors:\n#{resource.inspect_errors}"
      else
        additional = "\nvalidations not present"
      end
      message = "#{operation} returned false, resource:\n#{resource.attributes.pretty_inspect}#{additional}"
      raise SaveFailureError.new(message,resource)
    end
  end

  class Collection
    include RaiseSaveFailure
    def create_or_raise(*args)
      resource = create(*args)
      unless resource.saved?
        raise_save_failure(resource,:create_or_raise)
      end
      resource
    end
  end

  module Model
    include RaiseSaveFailure
    def create_or_raise(*args)
      resource = create(*args)
      unless resource.saved?
        raise_save_failure(resource,:create_or_raise)
      end
      resource
    end

    def first_or_create_or_raise(*args)
      resource = first_or_create(*args)
      unless resource.saved?
        raise_save_failure(resource,:first_or_create_or_raise)
      end
      resource
    end
  end

  module Resource
    include RaiseSaveFailure

    def save_or_raise(context=:default)
      result = save(context)
      unless result
        raise_save_failure(self,:save_or_raise,context)
      end
      result
    end

    def inspect_errors
      RaiseSaveFailure.format_errors(errors)
    end

    def save_or_raise!(*args)
      result = save!(*args)
      unless result
        raise_save_failure(self,:save_or_raise!)
      end
      result
    end

    def update_or_raise(*args)
      result = update(*args)
      unless result
        raise_save_failure(self,:update_or_raise!)
      end
      result
    end
  end
end
