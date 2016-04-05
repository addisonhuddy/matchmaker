class Team < ActiveRecord::Base
  has_many :students


  def self.match_teams_by_hour
    no_team = Student.all.to_a

    teams =  Hash.new{|hsh,key| hsh[key] = [] }
    team_index = 1
    Team.delete_all

    until no_team.count < 4
      student = no_team.sample
      no_team.delete(student)
      h = Hash.new

      no_team.each do |classmate|
        h[classmate] = student.array_overlap_score(classmate)
      end


      hs = h.sort_by {|k, v| v}.reverse.to_h

      team = Array.new
      team = hs.keys[0..2]

      team.each do |tm|
        no_team.delete(tm          )
      end

      team.push(student)
      teams[team_index] = team
      team_index += 1

      new_team = Team.create(name: "Team #{team_index - 1}")

      team.each do |tm|
        tm.update_attributes(team: new_team)
      end

    end

    reserve_team = Team.create(name: "Team Reserve")

    no_team.each do |tm|
      tm.update_attributes(team: reserve_team)
    end
    return 0
  end

end
