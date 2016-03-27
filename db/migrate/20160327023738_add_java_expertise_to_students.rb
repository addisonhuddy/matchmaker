class AddJavaExpertiseToStudents < ActiveRecord::Migration
  def change
    add_column :students, :java_expertise, :string
  end
end
