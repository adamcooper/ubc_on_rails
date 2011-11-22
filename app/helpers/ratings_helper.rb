module RatingsHelper


  def wrapper_for(form, object, field, &block)
    classes = object.errors[field] ? "clearfix error" : "clearfix"
    content_tag(:div, class: classes) do
      form.label(field) + content_tag(:div, class: 'input', &block)
    end
  end
end
