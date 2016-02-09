module ApplicationHelper
def title
    xtitle="Bokrana - Broadcast your Business"
    if @title.nil?
     xtitle
    else
      " #{@title} - #{xtitle} "
    end
  end


  def autocomplete_field name, path
    hash = Digest::MD5.hexdigest(name.to_s)
    output = text_field_tag("#{name}_autocomplete", nil, {  "class" => "rails-autocomplete", "data-autocomplete-parent" => hash, "data-autocomplete-url" => path, "data-provide" => "typeahead", "data-source" => "rails_autocomplete", "autocomplete" => "off" }).html_safe
    output << self.hidden_field(name, { "data-autocomplete-child" => hash }).html_safe
    output
  end

def link_to_next_page(scope, name, options = {}, &block)
  param_name = options.delete(:param_name) || Kaminari.config.param_name
  link_to_unless scope.last_page?, name, {param_name => (scope.current_page + 1)}, options.merge(:rel => 'next') do
    block.call if block
  end
end





end
