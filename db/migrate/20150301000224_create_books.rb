class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :isbn13
      t.date :published_date
      t.string :thumbnail
      t.text :description

      t.timestamps
    end
  end
end
