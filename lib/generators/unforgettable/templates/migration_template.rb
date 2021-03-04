# frozen_string_literal: true

class CreateUnforgettableReleases < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :unforgettable_releases do |t|
      t.string :version, null: false
      t.timestamps
    end
    add_index :unforgettable_releases, :version, unique: true
  end
end
