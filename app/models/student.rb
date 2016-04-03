class Student < ActiveRecord::Base
  belongs_to :team
  
  serialize :week_array, Array
  serialize :weekend_array, Array

  validates_presence_of(:name,
                        :time_zone,
                        :gatech_class,
                        :gatechuname,
                        :gatechid,
                        :email,
                        :learning_objectives,
                        :preferred_tools,
                        :myers_briggs,
                        :week_preferred,
                        :weekend_preferred)

  # validates_uniqueness_of :gatechid, :email, :gatechuname

  before_save :fill_week_array, :fill_weekend_array, :shift_time_array

  # return the number of overlaping hours two students have
  def array_overlap_score(s)
    week_overlap_array = s.week_array & self.week_array
    weekend_overlap_array = s.weekend_array & self.weekend_array
    return week_overlap_array.count + weekend_overlap_array.count
  end

  private

  def fill_week_array
    if self.week_preferred == "allday"
      self.week_array = [0, 0, 0, 0, 0, 0, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    elsif self.week_preferred == "daytime"
      self.week_array = [0, 0, 0, 0, 0, 0, 7, 8, 9, 10, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    elsif self.week_preferred == "afternoon"
      self.week_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 16, 17, 18, 0, 0, 0, 0, 0, 0]
    elsif self.week_preferred == "evening"
      self.week_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 21, 22, 23, 24]
    end
  end

  def fill_weekend_array
    if self.weekend_preferred == "allday"
      self.weekend_array = [0, 0, 0, 0, 0, 0, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    elsif self.weekend_preferred == "daytime"
      self.weekend_array = [0, 0, 0, 0, 0, 0, 7, 8, 9, 10, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    elsif self.weekend_preferred == "afternoon"
      self.weekend_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 16, 17, 18, 0, 0, 0, 0, 0, 0]
    elsif self.weekend_preferred == "evening"
      self.weekend_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 21, 22, 23, 24]
    end
  end

  # shift the student's hours to a standardize UTC
  def shift_time_array
    time_shift = Time.now.in_time_zone(self.time_zone).utc_offset
    time_shift = (time_shift/3600).round
    puts self.time_zone
    puts time_shift

    puts week_preferred
    if self.week_preferred != "allday"
      puts week_array.to_s
      self.week_array.map! { |hour| (hour != 0 ? (hour + (time_shift)) % 24 : 0 )}
      self.week_array.sort!
      puts week_array.to_s
    end

    puts weekend_preferred
    if self.weekend_preferred != "allday"
      puts weekend_array.to_s
      self.weekend_array.map! { |hour| (hour != 0 ? (hour + (time_shift)) % 24 : 0 )}
      self.weekend_array.sort!
      puts weekend_array.to_s
    end

  end

end
