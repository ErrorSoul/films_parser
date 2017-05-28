require 'nokogiri'
require 'open-uri'
require_relative 'product'


class Adapter
  attr_reader :page_url, :data, :films

  def initialize(page_url)
    @page_url = page_url
    @data = Nokogiri::HTML(open @page_url)
    @rate = 4
    @films = Array.new
  end

  def find_css(element)
    @data.css(element)
  end

  def good_rate?(obj)
    obj.rating >= @rate
  end

  def all_posts
   find_css('div.shortstory').each do |elem|
     product = get_product(elem)
     #puts elem
     puts product
     good_rate?(product) ? save(product) : next
   end
  end

  def save(product)
    @films.push product
  end

  private

  def get_product(elem)
    raw_product = elem.css('h2.zagolovki')
    puts "raw_product is #{raw_product}"
    rating = elem.css('li.current-rating').text.to_f
    puts raw_product.text
    puts raw_product
    Product.new(
     raw_product.text,
     raw_product.children.first['href'],
     rating
    )
  end

end
