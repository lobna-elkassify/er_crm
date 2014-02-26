class CreateErCrmDepartments < ActiveRecord::Migration
  def change
    create_table :er_crm_departments do |t|
      t.string :name, limit: 100
      t.timestamps
    end
  end
end
