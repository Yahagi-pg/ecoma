class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :title
      t.string :contributor
      t.datetime :posted
      t.string :content
      t.string :delete_key
      t.boolean :closed
      t.integer :server_id
      t.integer :category_id
      t.string :mac_address
      t.string :ip_address
      t.string :notification_email

      t.timestamps
    end
  end
end
