class AddIndexToUserId < ActiveRecord::Migration
  def change
    add_index :answers, :user_id
  end
end
