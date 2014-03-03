class CreateErCrmLeadTypes < ActiveRecord::Migration
  def change
    create_table :er_crm_lead_types do |t|
      t.string :name, :limit => 45
      t.integer :lead_category_id
      t.timestamps
    end

    add_foreign_key :er_crm_lead_types, :er_crm_lead_categories, column: "lead_category_id", name: "fk_lead_type_lead_category_id"
  end
end
