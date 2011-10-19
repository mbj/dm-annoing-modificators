require 'dm-core'
require 'pp'

module DataMapper
  module RaiseSaveFailure
    def raise_save_failure(resource,operation)
      if resource.respond_to? :errors
        additional = "\nerrors:\n#{format_errors(resource.errors)}"
      else
        additional = "\nvalidations not present"
      end
      message = "#{operation} returned false, resource:\n#{format_attributes(resource.attributes)}#{additional}"
      raise SaveFailureError.new(message,resource)
    end

    private

    def format_attributes(attributes,indent=2)
      attributes.pretty_inspect
    end

    def format_errors(errors)
      message = []
      errors.map do |errors|
        errors.each do |error|
          message << "#{error.attribute_name}: #{error.rule.class} - #{error.message}"
        end
      end
      message.join "\n"
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
    def save_or_raise(*args)
      result = save(*args)
      unless result
        raise_save_failure(self,:save_or_raise)
      end
      result
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
