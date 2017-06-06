class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :picture
      t.integer :bytes
      t.integer :order
      t.timestamps
    end
  end
end
