class BootstrapFormBuilder < ActionView::Helpers::FormBuilder

  def get_error_text(object, field, options)
    if object.nil? || options[:hide_errors]
      ""
    else
      errors = object.errors[field.to_sym]
      if errors.empty? then "" else errors.first end
    end
  end

  def jquery_datetime_select(field, options = {})
    with_custom_field_error_proc do
      datetime_picker_script = "<script type='text/javascript'>" +
            "$( function() { " +
              "$('##{id}')" +
              ".datetimepicker( $.datepicker.regional[ 'en-NZ' ] )" +
              ".datetimepicker( 'setDate', new Date('#{date_time}') ); } );" +
          "</script>"
      return basic_datetime_select(field, options.merge({javascript: datetime_picker_script}))
    end
  end

  def basic_datetime_select(field, options = {})
    with_custom_field_error_proc do
      input_class = options[:class] || 'date'
      placeholder_text = options[:placeholder_text] || 'Date'

      object = @template.instance_variable_get("@#{@object_name}")

      id = options[:id] || object.class.name.underscore + '_' + field.to_s

      errorText = get_error_text(object, field, options)
      wrapperClass = 'clearfix' + (errorText.empty? ? '' : ' error')
      errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
      help_block = help_block(options.delete(:help_block)) || ''
      label = label(field, options[:label])

      date_time =
        if options['start_time']
          options['start_time']
        elsif object.nil?
          DateTime.now.utc
        else
          object.send(field.to_sym)
        end

      javascript = options['javascript'] ||
        "<script>$(function() { $('##{id}').val(new Date($('##{id}').val()).toString('dd MMM, yyyy HH:mm')) });</script>"

      ("<div class='#{wrapperClass}'>" +
        label +
        "<div class='input'>" +
          super_text_field(field, {:id => id, :placeholder => placeholder_text, :value => date_time.to_s}.merge(options[:text_field] || {})) +
          errorSpan +
          help_block +
          javascript +
        "</div>" +
      "</div>").html_safe
    end
  end

  basic_helpers = %w{text_field text_area select email_field password_field check_box file_field}

  multipart_helpers = %w{date_select datetime_select}

  basic_helpers.each do |name|
    # First alias old method
    # class_eval("alias super_#{name.to_s} #{name}")

    define_method(name) do |field, *args|
      with_custom_field_error_proc do
        options = args.last.is_a?(Hash) ? args.pop : {}
        object = @template.instance_variable_get("@#{@object_name}")

        label = label(field, options[:label])
        errorText = get_error_text(object, field, options)
        help_block = help_block(options.delete(:help_block)) || ''
        wrapperClass = 'clearfix' + (errorText.empty? ? '' : ' error')
        errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
        field_params = args + [options]
              Rails.logger.debug "#{field_params.inspect}"
        ("<div class='#{wrapperClass}'>" +
            label +
            "<div class='input'>" +
              super(field, *field_params) +
              errorSpan +
              help_block +
            "</div>" +
          "</div>"
        ).html_safe
      end
    end
  end

  multipart_helpers.each do |name|
    define_method(name) do |field, *args|
      with_custom_field_error_proc do
        options = args.last.is_a?(Hash) ? args.pop : {}
        object = @template.instance_variable_get("@#{@object_name}")

        label = label(field, options[:label])

        errorText = get_error_text(object, field, options)
        help_block = help_block(options.delete(:help_block)) || ''
        wrapperClass = 'clearfix' + (errorText.empty? ? '' : ' error')
        errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
        ("<div class='#{wrapperClass}'>" +
            label +
            "<div class='input'>" +
              "<div class='inline-inputs'>" +
                super(field, *args) +
                errorSpan +
                help_block +
              "</div>" +
            "</div>" +
          "</div>"
        ).html_safe
      end
    end
  end

  def help_block content
    return nil unless content
    "<span class='help-block'>#{content}</span>"
  end

  def with_custom_field_error_proc(&block) # :nodoc:
    default_field_error_proc = ::ActionView::Base.field_error_proc
    ::ActionView::Base.field_error_proc = FIELD_ERROR_PROC
    yield
  ensure
    ::ActionView::Base.field_error_proc = default_field_error_proc
  end

  FIELD_ERROR_PROC = Proc.new do |html_tag, instance|
    html_tag
  end
end
