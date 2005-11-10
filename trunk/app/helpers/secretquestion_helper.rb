module SecretquestionHelper
  # Used in the form header <head>... </head>
  def page_head
   @page_head || 'Preguntas para la recuperaci&oacute;n de contrase&ntilde;as'
  end

  def description
     @description || title
  end

  # Used inside the body page
  def title
    @title || 'Preguntas para la recuperaci&oacute;n de contrase&ntilde;as'
  end

  def title_icon
    @title_icon || 'salvita_search_32x32.png'
  end

  def help_link
    @help_link || '/help/secretquestion/'
  end

  # Used in the views/secrectquestion/list.html
  def new_label
    'Agregar pregunta';
  end

  def purge_selected_label
    'Borrar preguntas seleccionadas';
  end
  
  def purge_selected_question
    "return confirm('¿Esta seguro que desea borrar todas las preguntas seleccionadas?');"
  end

  # Used in the partial salva/_render_stripes.html
  def show_purge_selected
    @show_purge_selected || 1 
  end

  def row_titles
    ['Pregunta', 'Consultar', 'Modificar', 'Borrar']
  end
 
  def destroy_question
    '¿Esta seguro que desea borrar  esta pregunta?'
  end
end
