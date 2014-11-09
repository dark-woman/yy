class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :user_id
      t.text :detail
      t.integer :feasibility
      t.integer :motivation
      t.integer :scale

      t.timestamps
    end
  end
end
