class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :fingerprint
      t.string :slug

      t.timestamps
    end
    add_index :identities, :slug
  end
end
