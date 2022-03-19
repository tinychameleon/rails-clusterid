class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :clusterid do |t|
      t.string :name

      t.timestamps
    end
  end
end
