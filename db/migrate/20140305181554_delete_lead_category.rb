class DeleteLeadCategory < ActiveRecord::Migration
  def change
    remove_foreign_key :er_crm_leads, name: 'fk_leads_lead_category_id'
    remove_index :er_crm_leads, :name => 'fk_leads_lead_category_id'
    remove_column :er_crm_leads, :lead_category_id
  end
end
