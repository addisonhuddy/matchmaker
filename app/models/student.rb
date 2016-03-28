class Student < ActiveRecord::Base
  validates_presence_of(:first_name,
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

  validates_uniqueness_of :gatechid, :email, :gatechuname
  
end
