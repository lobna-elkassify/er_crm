class AddLeadCategoryId < ActiveRecord::Migration
  def change
    change_table :er_crm_leads do |t|
      t.integer :lead_category_id
    end

    add_foreign_key :er_crm_leads, :er_crm_lead_categories, column: "lead_category_id", name: "fk_leads_lead_category_id"
  end
end
