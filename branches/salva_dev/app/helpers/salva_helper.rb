module SalvaHelper 
  
  def get_cfg(name)
    cfg = { 
      'institution_name' => 'Instituto de Física - UNAM',
      'institution_url' => 'http://www.fisica.unam.mx',
      'institution_administrative_key' => '-clave presupuestal-'
    }
    cfg[name] ? cfg[name] : name
  end
  
  def salva_column(name)
    column = { 
      # users
      'login' => 'Usuario',
      'passwd' => 'Contraseña',
      'userstatus_id' => 'Estado del usuario',
      'email' => 'Correo electrónico',
      'pkcs7' => 'Certificado para firma digital',
      # personals
      'firstname' => 'Nombre',
      'lastname1' => 'Apellido paterno',
      'lastname2' => 'Apellido materno',
      'sex' => 'Sexo',
      'dateofbirth' => 'Fecha',
      'birth_country_id' => 'País',
      'birthcity' => 'Ciudad',
      'birth_state_id' => 'Estado',
      'maritalstatu_id' => 'Estado civil',
      'photo' => 'Fotografía',
      'other' => 'Información adicional',
      # addresses
      'addresstype_id' => 'Tipo de dirección',
      'country_id' => 'País',
      'postaddress' => 'Dirección',
      'state_id' => 'Estado',
      'city' => 'Ciudad',
      'zipcode' => 'Código postal',
      'phone' => 'Teléfono(s)',
      'fax' => 'Fax',
      'movil' => 'Celular o radio',
    }
    
    column[name] ? column[name] : name
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
