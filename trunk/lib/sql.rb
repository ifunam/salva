module Sql
  def set_conditions(keys,values)
    [ set_conditions_from_keys(keys) ] + values
  end

  def set_conditions_from_keys(keys)
    keys.collect { |key| key + ' = ? ' }.join(' AND ')
  end
end
