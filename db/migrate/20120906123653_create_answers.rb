class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :body, :limit => 10000
      t.integer :user_id
      t.integer :question_id
      t.integer :rating, :default => 0, :null => false

      t.timestamps
    end

    add_index :answers, :user_id
    add_index :answers, :question_id
  end
end
