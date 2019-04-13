# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.text :canonical_url
      t.text :title
      t.text :author
      t.json :details
    end
  end
end
