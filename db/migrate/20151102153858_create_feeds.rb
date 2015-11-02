class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.text :content
      t.belongs_to :lecturer
      t.belongs_to :course

      t.timestamps null: false
    end
  end
end
