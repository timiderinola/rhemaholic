module ApplicationHelper
  # Returns the full title of a page
  def full_title(page_title)
    base_title = "Rhemaholic"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def friendly_date(d)
    d.strftime("%B %e, %Y")
  end
end
