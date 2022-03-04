class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings, id: :clusterid do |t|
      t.string :name
      t.string :value
      t.references :user, null: false, foreign_key: true, type: :clusterid

      t.timestamps
    end
  end
end
