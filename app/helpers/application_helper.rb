module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = nil)
    base_title = "SSP | Engineering Wiki"
    if page_title.nil? || page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
end
