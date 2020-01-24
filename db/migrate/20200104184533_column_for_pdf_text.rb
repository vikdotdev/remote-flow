class ColumnForPdfText < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :presentation_body_plain, :text
  end
end
