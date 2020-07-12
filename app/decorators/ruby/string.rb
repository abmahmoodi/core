class String
  def to_time_str
    "2000-01-01 #{self[0..1]}:#{self[2..3]} UTC".to_time
  end

  def utc_datetime_from
    "#{self} 00:00:00".in_time_zone('Tehran').in_time_zone('UTC').to_s
  end

  def utc_datetime_to
    "#{self} 23:59:59".in_time_zone('Tehran').in_time_zone('UTC').to_s
  end
end
