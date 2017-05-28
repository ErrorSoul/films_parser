class Pagerator
  attr_reader :num

  def initialize(num)
    @start = 1
    @num = num
    @page = "http://kinogo.club/filmy_2015/page/"
  end

  def to_enum
    @enumerator = Enumerator.new do |yielder|
      while @start <= @num
        yielder << page_url
        @start  += 1
      end
    end
  end

  def each
    to_enum.each do |x|
      yield x
    end
  end

  private

  def page_url
    @page + @start.to_s + '/'
  end
end
