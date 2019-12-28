class CreateNominations < ActiveRecord::Migration[6.0]
  def change
    create_table :nominations do |t|
      t.string :title
      t.string :description
      t.string :created_by
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
