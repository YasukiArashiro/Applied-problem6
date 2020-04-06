class AddFavoCountToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :favo_count, :integer
  end
end
