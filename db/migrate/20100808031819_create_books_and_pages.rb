class CreateBooksAndPages < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string   :title
      t.text     :description
      t.date     :published_at
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :pages do |t|
      t.string   :title
      t.text     :commentary
      t.date     :published_at
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :book_id
    end
    add_index :pages, [:book_id]
  end

  def self.down
    drop_table :books
    drop_table :pages
  end
end
