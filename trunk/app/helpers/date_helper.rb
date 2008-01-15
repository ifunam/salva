module DateHelper
  def month_select(object, attr=nil, opts={})
    months = [ ["Enero", 1], ["Febrero", 2], ["Marzo", 3], ["Abril", 4],
               ["Mayo", 5], ["Junio", 6], ["Julio", 7], ["Agosto", 8],
               ["Septiembre", 9], ["Octubre", 10], ["Noviembre", 11],
               ["Diciembre", 12] ]

    options = {:tabindex => opts[:tabindex], :prompt => '-- Seleccionar --'}
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

    select(object, attr || 'year', years, options);
  end

  def date_for_select(object, attr, tabindex, options={})
    # Tal vez alguien a los 90 años siga produciendo
    start_year = options[:start_year] || Date.today.year
    end_year =  options[:end_year] || start_year - 90
    date_select(object, attr || 'date', :start_year => start_year,
                :end_year => end_year, :use_month_numbers => true,
                :order => [:day, :month, :year], :tabindex => tabindex)
  end

  def auto_complete_year(object, attribute, tabindex, skip_default_year=false)
    
    default_year = 2007
    #skip_default_year ? (object.send(attribute) || nil) : (object.send(attribute) || (Date.today.year.to_i - 1))
    text_field_with_auto_complete(object, attribute, {:size => 4, :maxlength => 4, :tabindex => tabindex, :value => default_year}, :skip_style => true)
  end
end
