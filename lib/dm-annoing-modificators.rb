require 'dm-core'

module DataMapper
  class Collection
    def create_or_raise(*args)
      model = create(*args)
      unless model.saved?
        raise SaveFailureError.new("create returned false, #{self} was not saved, errors: #{model.errors.inspect}", self)
      end
      model
    end
  end

  module Model
    def create_or_raise(*args)
      model = create(*args)
      unless model.saved?
        raise SaveFailureError.new("create returned false, #{self} was not saved, errors: #{model.errors.inspect}", self)
      end
      model
    end
  end

  module Resource
    def save_or_raise(*args)
      result = save(*args)
      unless result
        raise SaveFailureError.new("save returned false, #{model} was not saved, errors: #{errors.inspect}", self)
      end
      result
    end

    def update_or_raise(*args)
      result = update(*args)
      unless result
        raise SaveFailureError.new("update returned false, #{model} was not saved, errors: #{errors.inspect}", self)
      end
      result
    end
  end
end
