 # Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # used
  def copyright
    @copyright || 'Universidad Nacional Aut&oacute;noma de M&eacute;xico'
  end

  def charset
    @charset || 'iso-8859-1'
  end

  def icon
    @icon || '/images/favicon.ico'
  end

  def style
    @style || 'form'
  end

  def help
    @help || "Ayuda"
  end

  def logout
    @logout || 'Salir'
  end

  def logout_link
    @logout_link || '/logout/'
  end

  def sendbug
    @sendbug || 'Informar de un error'
  end
  
  def sendbug_link
    @sendbug_link || '/sendbug/'
  end

  def user_label
    @user_label || 'Usuario'
  end
end
