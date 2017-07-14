class CreateSessions < ActiveRecord::Migration[5.1]
  def change

    # sessions table to store oauth2 code after 
    # successful authorization
    create_table :sessions do |t|
      t.text :encrypted_token
      t.string :encrypted_token_iv

      t.timestamps
    end

  end
end

