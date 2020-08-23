class CreateClientInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :client_invites do |t|
      t.integer :user_id
      t.string :gallery_id
      t.string :client_id
      t.boolean :status

      t.timestamps
    end
  end
end
