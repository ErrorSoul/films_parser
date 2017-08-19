require "../adapter"
require_relative "quote"


class CatAdapter < Adapter

  def all_posts
   find_css('div.quote.mediumText').each_with_index do |elem, ind|
     product = get_product(elem, ind)
     #puts elem
     puts product
     product.tweet_size? ? save(product) : next
   end
  end

  private

  def get_product(elem, ind)
    text = elem.children.css('div.quoteText').children.first.text.strip
    author = elem.children.css('a.authorOrTitle').children.first.text
    Quote.new(text, author, ind, @page_url)
  end
end
