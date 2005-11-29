module ListstripesHelper
  # Used in the partial views/salva/_list_stripes.rhtml
  def browse_label
    @browse_label || 'Consultar'
  end

  def browse_icon
    @browse_icon || 'invisible_16x16.png'
  end

  def edit_label
    @edit_label || 'Modificar'
  end

  def edit_icon
    @edit_icon || 'invisible_16x16.png'
  end

  def purge_label
    @purge_label || 'Borrar'
  end

  def purge_icon
    @purge_icon || 'invisible_16x16.png'
  end
end
