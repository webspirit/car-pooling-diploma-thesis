class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string   "email"
      t.string   "encrypted_password"
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count"
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "username"
      t.string   "phone"
      t.string   "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
    end
    add_index  :users, :confirmation_token, :unique => true
    add_index  :users, :email, :unique => true
    add_index  :users, :reset_password_token, :unique => true
  end
end