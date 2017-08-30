# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(password: "jegvarenganglækker", username: "Marie Skovgaard Larsen", email: "example@7861234678.com")
		

5.times do |work_num|
	Work.create!(title: "Mit mesterværk #{work_num}", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user_id: User.first.id, status: 1
	)
end

User.create!(password: "jegvarenganglækker", username: "Peter Højlund Andersen", email: "evample@jkasdkjldasl.dk")


5.times do |work_num|
	Work.create!(title: "Der var engang en gård #{work_num}", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user_id: User.last.id, status: 1
	)
end

names = %w(Henning Henrik Bobby Ole Anna Henriette)
names.length.times do |index|
	User.create!(password: "jegvarenganglækker", username: names[index], email: "test@teeest#{index}.dk")
end


puts "Created #{Work.all.length} works"