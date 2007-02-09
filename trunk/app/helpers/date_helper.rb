module DateHelper 
  def month_select(object, attr=nil, opts={})  
    months = [ ["Enero", 1], ["Febrero", 2], ["Marzo", 3], ["Abril", 4], 
               ["Mayo", 5], ["Junio", 6], ["Julio", 7], ["Agosto", 8], 
               ["Septiembre", 9], ["Octubre", 10], ["Noviembre", 11], 
               ["Diciembre", 12] ]

    options = {:tabindex => opts[:tabindex], :prompt => '-- Seleccionar --'}
    if opts[:required] == 1
      options['z:required'] = 'true'
      options['z:required_message'] = 'Seleccione una opción'
    end
    
    select(object, attr || 'month', months, options)
  end
  
  def year_select(object, attr=nil, opts={})
    y = Date.today.year
    start_year = opts[:start_year] || y - 90
    end_year = opts[:end_year] || y 

    years = [ ]
    for i in start_year .. end_year
      years << i
    end

    options = {:tabindex => opts[:tabindex], :prompt => '-- Seleccionar --'}
    if opts[:required] == 1
      options['z:required'] = 'true'
      options['z:required_message'] = 'Seleccione una opción'
    end
    
    select(object, attr || 'year', years, options);
  end
  
  def date_for_select(object, attr, tabindex)
    year = Date.today.year
    # Tal vez alguien a los 90 años siga produciendo
    start_year = year
    # Por si se aparece el pinche 'Doggie Hauser'
    # http://www.bbc.co.uk/comedy/bbctwocomedy/dogtelly/page31.shtml
    end_year = year - 90
    options = {:tabindex => tabindex}
    date_select(object, attr || 'date', :start_year => start_year, 
                :end_year => end_year, :use_month_numbers => true, 
                :order => [:day, :month, :year], :tabindex => tabindex)
  end
end
