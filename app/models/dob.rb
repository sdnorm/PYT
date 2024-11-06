class Dob
  def self.load(value)
    return nil if value.nil?
    value.is_a?(Time) ? value : Time.parse(value)
  end

  def self.dump(obj)
    return nil if obj.nil?
    case obj
    when Time, DateTime
      obj.to_s(:db)
    when Date
      obj.to_time.to_s(:db)
    when String
      Time.parse(obj).to_s(:db)
    else
      raise ArgumentError, "Invalid date format"
    end
  end
end
