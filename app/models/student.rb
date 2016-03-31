class Student < ActiveRecord::Base
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
      self.week_array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    elsif self.week_preferred == "daytime"
      self.week_array =[7, 8, 9, 10, 11, 12, 13, 14, 15]
    elsif self.week_preferred == "afternoon"
      self.week_array = [16, 15, 17, 18, 19]
    elsif self.week_preferred == "evening"
      self.week_array = [20, 21, 22, 23, 0, 1]
    end
  end

  def fill_weekend_array
    if self.weekend_preferred == "allday"
      self.weekend_array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    elsif self.weekend_preferred == "daytime"
      self.weekend_array =[7, 8, 9, 10, 11, 12, 13, 14, 15]
    elsif self.weekend_preferred == "afternoon"
      self.weekend_array = [16, 15, 17, 18, 19]
    elsif self.weekend_preferred == "evening"
      self.weekend_array = [20, 21, 22, 23, 0, 1]
    end
  end

  # shift the student's hours to a standardize UTC
  def shift_time_array
    time_shift = Time.now.in_time_zone(self.time_zone).utc_offset
    time_shift = (time_shift/3600).round
    self.week_array.map!    { |hour| (hour + (time_shift - 1)) % 23 }
    self.weekend_array.map! { |hour| (hour + (time_shift - 1)) % 23 }
  end

end
