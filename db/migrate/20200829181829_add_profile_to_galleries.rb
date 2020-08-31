class AddProfileToGalleries < ActiveRecord::Migration[6.0]
  def change
    add_column :galleries, :profile_photo, :string
  end
end
