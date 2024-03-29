class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.float :latitude
      t.float :longitude
      t.string :message
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
