class CreateContacts < ActiveRecord::Migration[6.1]
  def change

    create_table :contacts do |t|
      t.text :user_email
      t.text :message

      t.timestamps
    end 

  end
end
