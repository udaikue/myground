class RemovePublishedFromDiaries < ActiveRecord::Migration[6.1]
  def change
    remove_column :diaries, :published, :boolean
  end
end
