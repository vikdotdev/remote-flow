class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :organization_id
      t.string :role
      t.integer :sender_id
      t.string :token

      t.timestamps
    end
    add_index :token
  end
end
