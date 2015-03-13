class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :poster_id
      t.string :contributor
      t.datetime :posted
      t.string :content
      t.string :mac_address
      t.string :ip_address

      t.timestamps
    end
  end
end
