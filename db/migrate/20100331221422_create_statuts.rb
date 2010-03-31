class CreateStatuts < ActiveRecord::Migration
  def self.up
    create_table :statuts do |t|
      t.integer :user_id
      t.string :message
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :statuts
  end
end
