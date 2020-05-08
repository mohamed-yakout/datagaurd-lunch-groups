class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :week, null: false, foreign_key: true
      t.references :leader, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
