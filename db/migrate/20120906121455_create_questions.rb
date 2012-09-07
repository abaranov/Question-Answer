class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, :limit => 140
      t.string :body, :limit => 5000
      t.integer :user_id

      t.timestamps
    end
  end
end
