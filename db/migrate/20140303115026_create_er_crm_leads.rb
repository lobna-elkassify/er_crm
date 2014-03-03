class CreateErCrmLeads < ActiveRecord::Migration
  def change
    create_table :er_crm_leads do |t|
      t.text :comments
      t.integer :status_id
      t.integer :reservation_id
      t.integer :department_id
      t.integer :customer_id
      t.integer :lead_category_id
      t.integer :lead_type_id
      t.integer :follow_up_id
      t.integer :created_by_user_id
      t.integer :assigned_user_id

      t.timestamps
    end

    add_foreign_key :er_crm_leads, :er_crm_departments, column: "department_id", name: "fk_leads_department_id"
    add_foreign_key :er_crm_leads, :er_crm_customers, column: "customer_id", name: "fk_leads_customer_id"
    add_foreign_key :er_crm_leads, :er_crm_lead_categories, column: "lead_category_id", name: "fk_leads_lead_category_id"
    add_foreign_key :er_crm_leads, :er_crm_lead_types, column: "lead_type_id", name: "fk_leads_lead_type_id"
    add_foreign_key :er_crm_leads, :er_crm_follow_ups, column: "follow_up_id", name: "fk_leads_followup_id"
  end
end
