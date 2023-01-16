UserGroup.blueprint do
  group_id { Group.new.id }
  user_id { User.new.id }
  user
  group
end
