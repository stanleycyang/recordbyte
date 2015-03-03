class AddIndexToBooksIsbn13 < ActiveRecord::Migration
  def change
    add_index :books, :isbn13, unique: true
  end
end
