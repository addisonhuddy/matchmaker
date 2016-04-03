module ApplicationHelper
  include Ai4r::Data
  include Ai4r::Clusterers

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"   # Green
    when "error"
      "alert-danger"    # Red
    when "alert"
      "alert-warning"   # Yellow
    when "notice"
      "alert-info"      # Blue
    else
      flash_type.to_s
    end
  end

  def run_matchmaker
    students = Student.all
    students.each do |s1|
      print "#{s1.name}: "
      students.each do |s2|
        print s1.array_overlap_score(s2)
      end
      print "\n"
    end
  end

  def kmeans_teams
    students = Student.select("weekend_array")
    data = []
    students.each do |s|
      data.push(s.weekend_array)
    end
    p data
    ds = DataSet.new(:data_items => data)
    cluster = KMeans.new.build(ds, (data.count / 4))

    cluster.clusters.each_with_index do |cluster, index|
      puts "Group #{index+1}"
      cluster.data_items.each do |di|
        puts di.to_s
      end
      puts "==========="
    end
  end

  # method to randomly match students
  def match_teams_by_hour
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

    p teams.count
    p no_team.count

  end
end
