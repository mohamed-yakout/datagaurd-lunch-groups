class CreateWeeks < ActiveRecord::Migration[6.0]
  def change
    create_table :weeks do |t|
      t.integer :number
      t.date :start_date
      t.date :end_date
      t.integer :num_users_per_group

      t.timestamps
    end
  end
end
