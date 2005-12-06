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
      'dateofbirth' => 'Fecha de nacimiento',
      'birth_country_id' => 'País donde nació',
      'birthcity' => 'Ciudad',
      'birth_state_id' => 'Estado',
      'maritalstatu_id' => 'Estado civil',
      'photo' => 'Fotografía',
      'other' => 'Otra información o comentarios adicionales',
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
  
end
