class Group < ApplicationRecord
  belongs_to :week
  belongs_to :leader, class_name: User, foreign_key: 'leader_id'

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  # after_create :assign_users

  # Not Used
  def assign_users
    User.select('date(created_at) as ordered_date').order('RANDOM()').group(:unit_id).count(:id)
    units = Unit.order('RANDOM()')
    user_indexes_unit = units.map{|u| 0}

    users_by_unit = User.available.order('RANDOM()').all.group_by{|h| h[:unit_id]}

    i = 0

    while self.users.count < self.week.num_users_per_group do
      current_unit = units[i]
      current_user = users_by_unit[current_unit.id][user_indexes_unit[i]]


      GroupUser.new(user_id: current_user.id, group_id: self.id)


      user_indexes_unit[i] += 1
      i += 1
      i %= units.count
    end
  end
end
