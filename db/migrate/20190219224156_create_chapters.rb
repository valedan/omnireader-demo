class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.belongs_to :story, index: true
      t.text :title
      t.text :url
      t.integer :progess
    end
  end
end
