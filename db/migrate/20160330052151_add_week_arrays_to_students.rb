class AddWeekArraysToStudents < ActiveRecord::Migration
  def change
    add_column :students, :week_array, :string
    add_column :students, :weekend_array, :string
  end
end
