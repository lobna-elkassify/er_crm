class CreateErCrmFollowUps < ActiveRecord::Migration
  def change
    create_table :er_crm_follow_ups do |t|
      t.datetime :datetime
      t.text :description

      t.timestamps
    end
  end
end
