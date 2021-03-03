# frozen_string_literal: true

class CreateRakeReleases < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :cap_releases do |t|
      t.string :version, null: false
      t.timestamps
    end
    add_index :cap_releases, :version, unique: true
  end
end
