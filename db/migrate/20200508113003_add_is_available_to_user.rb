class AddIsAvailableToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_available, :boolean, default: true
  end
end
