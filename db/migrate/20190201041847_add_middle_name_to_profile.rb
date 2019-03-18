class AddMiddleNameToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :middle_name, :string
  end
end
