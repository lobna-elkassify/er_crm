class AddDepartmentCategoryId < ActiveRecord::Migration
  def change
    change_table :er_crm_departments do |t|
      t.integer :category_id
    end

    add_foreign_key :er_crm_departments, :er_crm_lead_categories, column: "category_id", name: "fk_department_lead_category_id"
  end
end
