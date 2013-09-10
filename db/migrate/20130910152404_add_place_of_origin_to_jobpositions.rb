class AddPlaceOfOriginToJobpositions < ActiveRecord::Migration
  def change
    add_column :jobpositions, :place_of_origin, :string
  end
end
