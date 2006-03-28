module DateHelper 
  def month_select(object, attr=nil, opts={})  
    months = [ ["Enero", 1], ["Febrero", 2], ["Marzo", 3], ["Abril", 4], 
               ["Mayo", 5], ["Junio", 6], ["Julio", 7], ["Agosto", 8], 
               ["Septiembre", 9], ["Octubre", 10], ["Noviembre", 11], 
               ["Diciembre", 12] ]
    select(object, attr || 'month', months, {}, {:tabindex => opts[:tabindex]})
  end
  
  def year_select(object, attr=nil, opts={})
    y = Date.today.year
    start_year = opts[:start_year] || y - 90
    end_year = opts[:end_year] || y 
    years = [ start_year .. end_year ]
    select(object, attr || 'year', years, {}, {:tabindex => opts[:tabindex]});
  end
  
  def date_for_select(object, attr=nil)
    year = Date.today.year
    # Tal vez alguien a los 90 años siga produciendo
    start_year = year - 90 
    # Por si se aparece el pinche 'Doggie Hauser'
    # http://www.bbc.co.uk/comedy/bbctwocomedy/dogtelly/page31.shtml
    end_year = year - 15 
    date_select(object, attr || 'date', :start_year => start_year, 
                :end_year => end_year, :use_month_numbers => true, 
                :order => [:day, :month, :year])
  end
end
