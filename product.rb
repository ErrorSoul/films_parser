class Product
  attr_accessor :title, :url, :rating

  def initialize(title, url, rating)
    @title = title
    @url = url
    @rating = rating
  end

  def to_s
    text = ""
    text << "*" * 25
    text << "\n"
    text << @title + "\n"
    text << @rating.to_s + "\n"
    text << @url + "\n"
    text << "*" * 25 + "\n"
  end
end
