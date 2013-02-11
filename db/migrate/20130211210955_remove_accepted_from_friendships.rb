class RemoveAcceptedFromFriendships < ActiveRecord::Migration
  def up
    remove_column :friendships, :accepted
  end

  def down
    add_column :friendships, :accepted, :binary
  end
end
