module ApplicationHelper

  def addClass categories
    categoryEntries = ""

    categories.split(",").map do |category|
      categoryEntries += ' <span class="' + category + '">' + category + '</span>'
    end

  categoryEntries.html_safe
  end
end
