RESUME = [  
          { :title => 'Datos personales',
            :query => 
            [ Person, ['lastname1', 'lastname2', 'firstname', 'country'], 
	    :all, {:conditions => [ 'user_id = ?', 2]} ]
          },
          { :title => 'Domicilios',
            :query => [Address, ['street', 'city', 'state', 'country'], :all, {:conditions => [ 'user_id = ?', 2]} ]
	 },
	 ]
