class AddDetailsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :gatech_class, :string
    add_column :students, :gatechuname, :string
    add_column :students, :gatechid, :integer
    add_column :students, :email, :string
    add_column :students, :learning_objectives, :text
    add_column :students, :preferred_tools, :text
    add_column :students, :myers_briggs, :string
    add_column :students, :week_preferred, :string
    add_column :students, :weekend_preferred, :string
  end
end
