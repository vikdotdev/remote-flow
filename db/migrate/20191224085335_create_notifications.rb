class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :body
      t.boolean :read, default: false
      t.references :notificable, polymorphic: true

      t.timestamps
    end

  end
end
