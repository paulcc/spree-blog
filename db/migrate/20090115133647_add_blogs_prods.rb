class AddBlogsProds < ActiveRecord::Migration
  def self.up
    create_table :blog_entries_products, :id => false do |t|
      t.column :blog_entry_id, :integer
      t.column :product_id, :integer
    end
  end

  def self.down
  end
end
