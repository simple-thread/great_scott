class AddAuthorIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :author, foreign_key: { to_table: :admins }
  end
end
