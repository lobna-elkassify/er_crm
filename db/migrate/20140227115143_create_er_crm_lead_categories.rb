class CreateErCrmLeadCategories < ActiveRecord::Migration
  def change
    create_table :er_crm_lead_categories do |t|
      t.string :name, limit: 100
      t.timestamps
    end
  end
end
