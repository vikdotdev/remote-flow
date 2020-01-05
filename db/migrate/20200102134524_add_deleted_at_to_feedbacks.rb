class AddDeletedAtToFeedbacks < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbacks, :deleted_at, :datetime
    add_index :feedbacks, :deleted_at
  end
end
