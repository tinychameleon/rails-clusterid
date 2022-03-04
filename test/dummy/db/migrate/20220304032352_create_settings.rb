class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.clusterid :id
      t.string :name
      t.string :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
