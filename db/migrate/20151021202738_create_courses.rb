class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.belongs_to :lecturer

      t.timestamps null: false
    end
  end
end
