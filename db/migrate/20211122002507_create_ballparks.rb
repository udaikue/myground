class CreateBallparks < ActiveRecord::Migration[6.1]
  def change
    create_table :ballparks do |t|
      t.string :name, null: false
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
