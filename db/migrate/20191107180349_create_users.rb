# frozen_string_literal: true

# ce takui sobi class
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :role
      t.string :avatar

      t.timestamps
    end
  end
end
