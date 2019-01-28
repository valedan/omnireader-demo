class CreateStrategies < ActiveRecord::Migration[5.2]
  def change
    create_table :strategies do |t|
      t.string :domains, array: true
      t.json :targets
      t.timestamps
    end
  end
end
