class CreateArtworks < ActiveRecord::Migration[6.0]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :artist
      t.string :edition
      t.integer :year
      t.string :medium
      t.string :description
      t.boolean :availability
      t.boolean :preview
      t.boolean :commission
      t.integer :gallery_id

      t.timestamps
    end
  end
end
