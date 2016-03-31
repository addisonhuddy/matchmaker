module ApplicationHelper
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

  def count_matches
    students = Student.all
    students.each do |s1|
      overlap_count = 0
      print "#{s1.name}: "
      students.each do |s2|
        if s1.array_overlap_score(s2) == 3
          overlap_count += 1
        end
      end
      puts overlap_count
    end
  end
end
