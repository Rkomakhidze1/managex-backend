class AddTeamIdsToUsersAndProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :team_id, :int
    add_column :projects, :team_id, :int
  end
end
