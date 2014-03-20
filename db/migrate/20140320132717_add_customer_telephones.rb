class AddCustomerTelephones < ActiveRecord::Migration
  def change
    rename_column :er_crm_customers, :phone, :home_phone

    change_table :er_crm_customers do |t|
      t.string :work_phone, limit: 45
      t.string :fax_number, limit: 45
      t.string :mobile_number, limit: 45
    end
  end
end
