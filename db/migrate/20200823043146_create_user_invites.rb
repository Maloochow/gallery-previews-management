class CreateUserInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :user_invites do |t|
      t.integer :user_id
      t.string :new_user_email

      t.timestamps
    end
  end
end
