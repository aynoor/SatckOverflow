class ChangeAnswerToAnsDescription < ActiveRecord::Migration
  def change
    rename_column :Answers, :answer, :ans_description
  end
end
