class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :username
      t.string :repository_name
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
