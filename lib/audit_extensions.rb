require 'audited-activerecord'
class Audited::Adapters::ActiveRecord::Audit
  before_save do |a|
    if a.auditable_type == "ErCrm::Lead"

      if a.action == "create"
        a.audited_changes = "Lead Created"
      else
        update_lead_changes(a)
      end
    #workaround to save the followup audit as a lead change (audited gem doesnt support auditing childs)
    elsif a.auditable_type == "ErCrm::FollowUp" && a.action == "update"
      a.auditable_id = a.auditable.lead.id
      a.auditable_type = "ErCrm::Lead"

      new_audited_changes = {}
      a.audited_changes.each do |changed_field, changes|
        case changed_field
        when "datetime"
          new_audited_changes["Follow up"] = changes
        when "description"
          new_audited_changes["Follow up Message"] = changes
        end
      end

      a.audited_changes = new_audited_changes
    end

  end

  private
  def update_lead_changes(audit)
    new_audited_changes = {}
    changes_keys = audit.audited_changes.keys

    audit.audited_changes.each do |changed_field, changes|
      case changed_field
        when 'status_id'
          new_audited_changes["Status"] = [ErCrm::Status.find_by_id(changes.first).try(:name),
                                           ErCrm::Status.find_by_id(changes.last).try(:name)]
          changes_keys.delete(changed_field)
        when 'customer_id'
          new_audited_changes["Customer"] = [ErCrm::Customer.find_by_id(changes.first).try(:name), 
                                             ErCrm::Customer.find_by_id(changes.last).try(:name)]
          changes_keys.delete(changed_field)
        when 'lead_type_id'
          new_audited_changes["Lead Type"] = [ErCrm::LeadType.find_by_id(changes.first).try(:name), 
                                              ErCrm::LeadType.find_by_id(changes.last).try(:name)]
          changes_keys.delete(changed_field)
        when 'department_id'
          new_audited_changes["Department"] = [ErCrm::Department.find_by_id(changes.first).try(:name), 
                                               ErCrm::Department.find_by_id(changes.last).try(:name)]
          changes_keys.delete(changed_field)
        when 'assigned_user_id'
          new_audited_changes["Assigned User"] = [User.find_by_id(changes.first).try(:name), 
                                                  User.find_by_id(changes.last).try(:name)]
          changes_keys.delete(changed_field)
        when 'created_by_user_id'
          new_audited_changes["Owner User"] = [User.find_by_id(changes.first).try(:name), 
                                               User.find_by_id(changes.last).try(:name)]
          changes_keys.delete(changed_field)
        when 'follow_up_id'
          if !changes.first.nil? && changes.last.nil?
            new_audited_changes["Follow up"] = "on #{ErCrm::Lead.find(audit.auditable_id).follow_up.try(:datetime)} finished"
          elsif changes.first.nil? && !changes.last.nil?
            new_audited_changes["Follow up"] = "on #{ErCrm::FollowUp.find(changes.last).try(:datetime)} created"            
          end
          changes_keys.delete(changed_field)            
      end
    end

    new_audited_changes.merge!(audit.audited_changes.slice(* changes_keys))

    #workaround to get the followup audit (audited gem doesn't support auditing childs)
    last_created_update = audit.auditable.audits.where(:action => 'update').last
    if last_created_update.created_at >= Time.now - 1.minutes
      new_audited_changes.merge!(last_created_update.audited_changes)
      last_created_update.destroy
    end

    audit.audited_changes = new_audited_changes
  end      
end