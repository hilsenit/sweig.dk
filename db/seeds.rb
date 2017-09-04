

marie = User.new(password: "Figoer4nice", password_confirmation: "Figoer4nice", username: "mariemus", email: "okayda@marie.dk")
marie.skip_confirmation!
marie.save!
		

5.times do |work_num|
	Work.create!(title: "Mit mesterværk #{work_num}", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user_id: User.first.id, status: 1
	)
end

peter = User.new(password: "Figoer4nice", password_confirmation: "Figoer4nice", username: "petermus", email: "okay@peter.dk")
peter.skip_confirmation!
peter.save!


5.times do |work_num|
	Work.create!(title: "Der var engang en gård #{work_num}", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user_id: User.last.id, status: 1
	)
end

20.times do |i| 
	User.last.stories << Story.create(story_type: "following", action_username: User.last.username,  t_other_username: User.first.username, t_other_friendly_id: User.last.slug)
end
20.times do |i| 
	User.last.stories << Story.create(story_type: "followed",  t_other_username: User.first.username, t_other_friendly_id: User.last.slug)
end

20.times do |i| 
	User.last.stories << Story.create(story_type: "work",  t_other_username: User.first.username, t_other_friendly_id: User.last.slug, work_friendly_id: User.last.works.last.slug, work_title: User.last.works.last.title)
end

puts "Created #{Work.all.length} works"
puts "Created #{Story.all.length} stories"