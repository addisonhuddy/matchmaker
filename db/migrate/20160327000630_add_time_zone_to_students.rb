class AddTimeZoneToStudents < ActiveRecord::Migration
  def change
    add_column :students, :time_zone, :string
  end
end
