class AddRateToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rate, :integer, :default => 0, :null => false
  end
end
