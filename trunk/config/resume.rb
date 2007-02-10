RESUME = [ 
          { :title => 'Datos personales',
            :query => 
            [ Person, ['lastname1', 'lastname2', 'firstname', 'country_id'], :all, {:conditions => [ 'user_id = 2']} ]
          },
          { :title => 'Domicilios',
            :query => [Address, ['address', 'country_id'], :all, {:conditions => [ 'user_id = 2']} ]
          },
         ]
