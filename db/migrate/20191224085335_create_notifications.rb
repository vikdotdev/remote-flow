class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.references :notificable, polymorphic: true
      t.references :user
      t.string :notification_type

      t.timestamps
    end

    add_index :notifications, :read
  end
end
