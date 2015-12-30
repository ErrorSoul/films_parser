require_relative 'pagerator'
require_relative 'adapter'

page_queue = Queue.new
main_queue = Queue.new

pagerator = Pagerator.new(47).to_enum

pagerator.each do |page|
  page_queue << page
end

threads = 5.times.map do |n|
  Thread.new do
    begin
      while page = page_queue.pop(true)
        adapter = Adapter.new(page)
        adapter.all_posts
        #puts adapter.films
        main_queue << adapter.films
      end
    rescue ThreadError
    end
  end
end
threads.each(&:join)
thread = Thread.new do
  file = File.open('result.txt', 'wb')
  begin
    puts 'im starting'
    
    while line = main_queue.pop(true)
      file.puts line
    end
  rescue ThreadError
    file.close
  end
end

thread.join


