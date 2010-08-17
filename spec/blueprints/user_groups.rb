UserGroup.blueprint do
  group_id { Group.make!.id }
  user_id { User.make!.id }
  user
  group
end
