CONFIG = [  
          { :title => 'Datos personales',
            :query => 
            [ Person, ['lastname1', 'lastname2', 'firstname', 'country'], 
	    :first, {:conditions => [ 'user_id = ?', 2]} ]
          },
          { :title => 'Domicilios',
            :query => [Address, ['location', ['city', 'name'],  'state', 'country'], :all, {:conditions => [ 'user_id = ?', 2]} ]
	 },
	 ]
