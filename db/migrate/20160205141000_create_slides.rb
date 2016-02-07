class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :Course
      t.string :Title
      t.string :Instructor

      t.timestamps null: false
    end
  end
end
