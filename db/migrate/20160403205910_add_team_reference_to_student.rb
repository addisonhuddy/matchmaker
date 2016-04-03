class AddTeamReferenceToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :team, index:true
  end
end
