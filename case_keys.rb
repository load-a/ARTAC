# This allows Keyboard input arrays to be processed in a switch statement.
# Apparently it doesn't need to be required to be active.
class ::Symbol

  def ===(other)
    case other
    when ::Array
      other.include?(self)
    else 
      super
    end
  end

end

class ::Numeric
  def ===(other)
    case other
    when ::Array
      other.include? self
    else
      super
    end
  end
end
