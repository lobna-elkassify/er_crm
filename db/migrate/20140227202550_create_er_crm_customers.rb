class CreateErCrmCustomers < ActiveRecord::Migration
  def change
    create_table :er_crm_customers do |t|
      t.string :email, limit: 45
      t.string :first_name, limit: 45
      t.string :last_name, limit: 45
      t.string :phone, limit: 45
      t.integer :source_id
      t.integer :region_id
      t.integer :country_id
      t.string :city, limit: 45
      t.string :zip_code, limit: 45
      t.string :street_address, limit: 45
      t.integer :created_by_user_id
      t.integer :customer_user_id

      t.timestamps
    end
  end
end
