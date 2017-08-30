class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :nickname
      t.string :password
      t.string :title
      t.string :phone
      t.string :content
      t.timestamps null: false
    end
  end
end
