class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.text :canonical_url
      t.json :details
    end
  end
end
