module Sql
  def set_conditions(keys,values)
    [ sql_conditions_from_keys(keys) ] + values
  end

  def sql_conditions_from_keys(keys)
    keys.collect { |key| key + ' = ? ' }.join(' AND ')
  end

  def set_conditions_by_ids_and_like(hash)
    [ sql_conditions_by_ids_and_like(hash.keys) ] + hash.values
  end
  
  def sql_conditions_by_ids_and_like(keys)
    keys.collect { |key| 
      if key.match(/_id$/) 
        key + ' = ?'
      else
        key + ' LIKE ?' 
      end
      }.join(' AND ')	
  end
end
