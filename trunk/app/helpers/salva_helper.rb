module SalvaHelper 
  
  def get_cfg(name)
    cfg = { 
      'institution_name' => 'Instituto de Física - UNAM',
      'institution_url' => 'http://www.fisica.unam.mx',
      'institution_administrative_key' => '-clave presupuestal-'
    }
    cfg[name] ? cfg[name] : name
  end
  
  def get_label(name)
    ymlfile =  File.join(RAILS_ROOT, 'po', 'salva.yml')
    salva = YAML::parse( File.open(ymlfile) )
    column = salva.transform    
    column[name] ? column[name] : "#{name} no esta definido en #{ymlfile}"
  end

  # Title icon
  def title_icon
    "#{@controller.controller_class_name}_32x32.png"
  end
  
  # Title
  def title
    titles = { 
      'PersonalController' => 'Datos personales',
      'AddressesController' => 'Domicilio(s)',
      'BookController' => 'Libros',
      'ArticlesController' => 'Articles',
    }
   titles[@controller.controller_class_name] ? titles[@controller.controller_class_name] : @controller.controller_class_name
  end


end
