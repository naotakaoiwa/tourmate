class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string     :title,    null: false
      t.text       :plan,     null: false
      t.string     :language, null: false
      t.string     :time,     null: false
      t.integer    :area_id,  null: false
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
