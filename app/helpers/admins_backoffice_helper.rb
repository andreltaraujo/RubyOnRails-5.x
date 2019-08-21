module AdminsBackofficeHelper

  def translate_method(object = nil, method = nil)
    if object && method
      object.model.human_attribute_name(method)
    else
      "Message"
    end
  end
end
