class AddPageTitleAndPageBodyToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :body, :text
  end
end
