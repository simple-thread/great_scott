class AddAuthorBooleanToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :author, :boolean, default: false, null: false
  end
end
