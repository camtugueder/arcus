class AddTokenToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :token, :string
  end
end
