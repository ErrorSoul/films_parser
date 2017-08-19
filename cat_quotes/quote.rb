Quote = Struct.new(:text, :author, :ind, :url) do
  def to_s
    str = ""
    str << "*" * 25
    str << "\n"
    str << text + "\n"
    str << "Author: "
    str << author + "\n"
  end

  def size
    (text + author).size
  end

  def tweet_size?
    size <= 140
  end
end
