class RemoveGalleryIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :gallery_id
  end
end
