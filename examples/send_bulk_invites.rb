require "bundler/setup"
require "velocity"

contributors_list = CSV.parse(File.read("./examples/contributors-list.csv"), headers: true)

contributors_list.map do |contributor|
  velocity_contributor = Velocity::Contributor.find_by(name: contributor["name"])

  if velocity_contributor
    puts "Contributor #{velocity_contributor.id} found.\n#{velocity_contributor.inspect}"
  else
    role = Velocity::Role.find_by(name: contributor["role_name"])

    raise "Role not found" if role.nil?

    invite = Velocity::Invite.create(
      name: contributor["name"],
      email: contributor["email"],
      job_function: contributor["job_function"],
      role_ids: [role.id]
    )

    puts "Invite #{invite.id} sent.\n#{invite.inspect}"
  end
end
