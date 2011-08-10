require 'dm-core'

module DataMapper
  module RaiseSaveFailure
    def raise_save_failure(resource,operation)
      message = "#{operation} returned false\nresource:\n#{resource.attributes.inspect}\nerrors:\n#{format_errors(resource.errors)}"
      raise SaveFailureError.new(message)
    end

    private

    def format_errors(errors)
      errors.map do |attribute_name,errors|
        "#{attribute_name}:\n#{errors.map { |error| "#{error.rule.class} - #{error.custom_message}" }}"
      end.join("\n")
    end
  end

  class Collection
    include RaiseSaveFailure
    def create_or_raise(*args)
      resource = create(*args)
      unless resource.saved?
        raise_save_failure(resource,:create_or_raise)
      end
      model
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
