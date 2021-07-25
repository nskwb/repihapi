module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'REPIHAPI'

    page_title.blank? ? base_title : page_title + ' / ' + base_title
  end
end
