module ApplicationHelper

  def nav_link(text, url)
    options = current_page?(url) ? {class: 'active'} : {}

    content_tag(:li, options) do
      link_to text, url
    end
  end

end
