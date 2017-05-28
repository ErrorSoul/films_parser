Product = Struct.new( :title, :url, :rating) do
  def to_s
    text = ""
    text << "*" * 25
    text << "\n"
    text << title + "\n"
    text << "Rating: "
    text << rating.to_s + "\n"
    text << url + "\n"
  end
end
