class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
    	t.integer :resume_id
    	t.string :path
      t.timestamps null: false
    end
  end
end
