
class Pagerator
  attr_reader :num
  
  def initialize(num)
    @start = 1
    @num = num
    @page = "http://kinogo.co/filmy_2013/page/"
  end

  def to_enum
    @enumerator = Enumerator.new do |yielder|
      while @start <= @num
        yielder << @page + @start.to_s + '/'
        @start  += 1
      end
    end
  end

  def each
    to_enum.each do |x|
      yield x
    end
  end

end
