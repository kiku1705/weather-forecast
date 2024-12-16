module ApplicationHelper
  def is_cache_hit(value)
    value == true ? "text-success" : "text-dark"
  end

  def message_is?(type)
    case type
    when "error"
      "alert alert-danger"
    when "info"
      "alert alert-info"
    when "success"
      "alert alert-primary"
    else
      "alert alert-light"
    end
  end 
end
