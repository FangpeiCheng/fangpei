class RemoveMicropostFromDreams < ActiveRecord::Migration
  def change
    remove_reference :dreams, :micropost, index: true, foreign_key: true
  end
end
