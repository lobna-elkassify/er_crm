module ErCrm
  module ApplicationHelper
    def render_edit_text_field(field_name, field_value, options = {})
      content_tag(:div, 
                  [
                    display_markup(field_name, field_value, options), 
                    edit_text_markup(field_name, field_value, options)
                  ].join(' '), 
                  {:class => 'controls'}, 
                  false)
    end

    def render_edit_email_field(field_name, field_value, options = {})
      content_tag(:div, 
                  [
                    display_email_markup(field_name, field_value), 
                    edit_text_markup(field_name, field_value, options)
                  ].join(' '), 
                  {:class => 'controls'}, 
                  false)
    end

    def render_edit_select_field(field_name, field_value, select_values, options = {})
      edit_markup = content_tag(:span,
                                [
                                  select_tag(field_name, options_for_select(select_values.collect{ |option| [option.name, option.id] }, field_value), {:class => "field_value"}),
                                  content_tag(:span, '', class: "help-block js-error hidden"),
                                  link_to('#', class: "btn btnEditSave icn-save 
                                                      #{field_name}") {content_tag(:i, '', class: 'icon-save')}
                                ].join(' '),
                                {:class => "js-upload hidden"}, false)

      content_tag(:div, 
                  [
                    display_markup(field_name, select_values.select{|option| option.id.to_s == field_value}.first.try(:name), options), 
                    edit_markup
                  ].join(' '), 
                  {:class => 'controls'}, 
                  false)
    end

    private
    def display_markup(field_name, field_value, options = {})
      display_wrapper = options[:display_wrapper] || :p
      content_tag(:span,
                  [
                    content_tag(display_wrapper, field_value, class: 'field_value'),
                    link_to('#', class: "btn btnEditSave js-btnEditSave icn-edit hidden") {content_tag(:i, '', class: 'icon-pencil')},
                    content_tag(:div, '', {class: 'success_msg hidden', style: 'color:green'})
                  ].join(' '),
                  {:class => "js-edit #{field_name}"}, 
                  false)
    end

    def display_email_markup(field_name, field_value)
      content_tag(:span,
                  [
                    link_to("mailto:#{field_value}", class: "field_value"){ field_value },
                    link_to('#', class: "btn btnEditSave js-btnEditSave icn-edit hidden") {content_tag(:i, '', class: 'icon-pencil')},
                    content_tag(:div, '', {class: 'success_msg hidden', style: 'color:green'})
                  ].join(' '),
                  {:class => "js-edit #{field_name}"}, 
                  false)
    end

    def edit_text_markup(field_name, field_value, options = {})
      content_tag(:span,
                  [
                    text_field_tag(field_name, field_value, {:class => "field_value #{options[:edit_input_class]}"}),
                    content_tag(:span, '', class: "help-block js-error hidden"),
                    link_to('#', class: "btn btnEditSave icn-save 
                                        #{field_name}") {content_tag(:i, '', class: 'icon-save')}
                  ].join(' '),
                  {:class => "js-upload hidden"}, false)
    end
  end
end
