class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :telegram_id
      t.string :first_name
      t.string :last_name
      t.string :bot_command_data, default: ""

      t.timestamps null: false
    end
  end
end
