class AddGalleryIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gallery_id, :integer
  end
end
