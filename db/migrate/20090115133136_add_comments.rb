class AddComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :user_id, :integer
      t.column :blog_entry_id, :integer
      t.column :body, :text
      t.column :approved, :boolean, :default => false
      t.timestamps
    end
  end
    
  def self.down
    drop_table :comments
  end
end
