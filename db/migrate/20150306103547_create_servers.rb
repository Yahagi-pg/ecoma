class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :server
      t.string :label
      t.timestamps
    end
  end
end
