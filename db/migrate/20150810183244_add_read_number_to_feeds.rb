class AddReadNumberToFeeds < ActiveRecord::Migration
  def change
      add_column :feeds, :ReadNumber, :int
  end
end
