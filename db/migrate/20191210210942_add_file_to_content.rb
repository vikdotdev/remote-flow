class AddFileToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :file, :string
  end
end
