module Admin::VolunteerSubmissionsHelper
  def status_bg_color(status)
    case status.to_s
    when "pending" then "#FEF3C7"
    when "contacted" then "#DBEAFE"
    when "confirmed" then "#DCFCE7"
    when "inactive" then "#F3F4F6"
    else "#F3F4F6"
    end
  end

  def status_text_color(status)
    case status.to_s
    when "pending" then "#92400E"
    when "contacted" then "#1E40AF"
    when "confirmed" then "#166534"
    when "inactive" then "#6B7280"
    else "#6B7280"
    end
  end
end
