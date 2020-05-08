class Week < ApplicationRecord
  after_create :generate_groups

  def generate_groups
    num_groups = User.available.count / self.num_users_per_group

    (1..num_groups).each do |group_number|
      Group.create(number: group_number, week_id: self.id)
    end

    assign_users_to_groups
  end

  def assign_users_to_groups
    User.select('date(created_at) as ordered_date').order('RANDOM()').group(:unit_id).count(:id)
    units = Unit.order('RANDOM()')
    user_indexes_unit = units.map{|u| 0}

    groups = self.groups

    users_by_unit = User.available.order('RANDOM()').all.group_by{|h| h[:unit_id]}

    i = 0

    groups.each do |group|
      while group.users.count < self.num_users_per_group do
        current_unit = units[i]
        current_user = users_by_unit[current_unit.id][user_indexes_unit[i]]


        GroupUser.new(user_id: current_user.id, group_id: group.id)


        user_indexes_unit[i] += 1
        i += 1
        i %= units.count
      end
    end
  end
end
