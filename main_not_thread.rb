require_relative 'pagerator'
require_relative 'adapter'

pagerator  = Pagerator.new(47)
file = File.open('result_another.txt', 'wb')

pagerator.each do |page|
  adapter = Adapter.new page
  adapter.all_posts
  file.puts adapter.films
end

file.close
