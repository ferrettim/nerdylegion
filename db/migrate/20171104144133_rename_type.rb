class RenameType < ActiveRecord::Migration[5.1]
  def change
    rename_column :episodes, :type, :itunestype
  end
end
