require "bundler/setup"
require "velocity"

contributor = Velocity::Contributor.find_by(email: "vgsantoniazzi@gmail.com")

if contributor
  puts "Contributor #{contributor.id} found.\n#{contributor.inspect}"
else
  engineer_role = Velocity::Role.find_by(name: "Engineer")

  raise "Role not found" if engineer_role.nil?

  invite = Velocity::Invite.create(
    name: "Victor Antoniazzi",
    email: "vgsantoniazzi@gmail.com",
    job_function: "Software Engineer",
    role_ids: [engineer_role.id]
  )

  puts "Invite #{invite.id} sent.\n#{invite.inspect}"
end
