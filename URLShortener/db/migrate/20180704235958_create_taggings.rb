class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.string :topic, null: false
      t.integer :url_id, null: false
    end
    add_index :taggings, [:topic, :url_id] 
  end
end
