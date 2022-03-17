class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :title
      t.references :admin, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
