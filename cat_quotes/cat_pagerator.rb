require "../pagerator"

class CatPagerator < Pagerator

  private

  def page
    "http://www.goodreads.com/quotes/tag/cats"
  end

  def page_url
    page + "?page=#{@start.to_s}"
  end
end
