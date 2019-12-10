class AddPageTitleAndPageBodyToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :page_title, :string
    add_column :contents, :page_body, :text
  end
end
