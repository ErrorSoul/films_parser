require_relative 'cat_pagerator'
require_relative 'cat_adapter'
require 'yaml/dbm'

page_queue = Queue.new
main_queue = Queue.new

pagerator = CatPagerator.new(26)
db = YAML::DBM.open('r', 0666, DBM::WRCREAT)
pagerator.each do |page|
  puts "Page is #{page}"
  page_queue << page
end

threads = 10.times.map do |n|
  Thread.new do
    begin
      puts "I m thread number #{n}"
      while page = page_queue.pop(true)
        puts "My page is #{page}"
        adapter = CatAdapter.new(page)
        adapter.all_posts
        puts adapter.films
        main_queue << adapter.films
      end
    rescue ThreadError
    end
  end
end

threads.each(&:join)

thread = Thread.new do
  file = File.open('result.txt', 'wb')
  array = []
  begin
    puts 'im starting'

    while line = main_queue.pop(true)
      puts line
      file.puts line
      array << line
      db["a"] = array
    end
  rescue ThreadError
    file.close
  end
end

thread.join
