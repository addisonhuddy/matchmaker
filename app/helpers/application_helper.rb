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

  def cluster_teams
    students = Student.select("weekend_array")
    data = []
    students.each do |s|
      data.push(s.weekend_array)
    end
    p data
    ds = DataSet.new(:data_items => data)
    cluster = KMeans.new.build(ds, 63)

    cluster.clusters.each_with_index do |cluster, index|
      puts "Group #{index+1}"
      cluster.data_items.each do |di|
        puts di.to_s
      end
      puts "==========="
    end
  end

  def count_matches
    students = Student.all
    students.each do |s1|
      overlap_count = 0
      students.each do |s2|
        if s1.array_overlap_score(s2) >= 3
          overlap_count += 1
        end
      end
      if overlap_count < 3
        print "#{s1.name}: "
        puts overlap_count
      end
    end
  end
end
