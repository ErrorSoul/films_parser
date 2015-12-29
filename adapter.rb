require 'nokogiri'
require 'open-uri'


class Adapter
  attr_reader :site_name, :data, :films

  def initialize(site_name)
    @site_name = site_name
    @data = Nokogiri::HTML(open @site_name)
    @rate = 4
    @films = Array.new
  end

  def find_css(element)
    @data.css(element)
  end

  def rating(obj)
    obj.css('li.current-rating').text.to_i
  end

  def title(obj)
    title_obj = obj.css('h2.zagolovki')
    [title_obj.text, title_obj.children.first['href']]
  end
     
  def good_rate?(obj)
    rating(obj) >= @rate
  end

  def all_posts
   find_css('div.shortstory').each do |elem|
     good_rate?(elem) ? save_film(elem) : next
   end
  end

  def save_film(elem)
    @films.push title(elem)
  end
    
end
