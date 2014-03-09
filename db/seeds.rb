departments = ['Central Reservations', 'Los Angeles Self Drive Tours', 'Los Angeles Guided Tours']
['Rentals', 'Self Drive Tours', 'Guided Tours'].each_with_index do |category, index|
  c = ErCrm::LeadCategory.find_or_initialize_by_name (category)
  unless c.departments.collect(&:name).include? (departments[index])
    c.departments.build({:name => departments[index]})
  end
  unless c.lead_types.collect(&:name).include? ('Contact Request')
    c.lead_types.build({:name => 'Contact Request'})
  end
  c.save!
end