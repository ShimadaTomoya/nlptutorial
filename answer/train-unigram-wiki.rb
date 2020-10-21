count = {}
total_count = 0
train_file = '../data/wiki-en-train.word'

File.open(train_file, 'r') do |f|
  words = []
  while (line = f.gets) do
    words.push(*line.split(' '))
    words.push('</s>')
  end
    words.each do |word|
      count[word] ? count[word] += 1 : count[word] = 1
      total_count += 1
    end
end

File.open('model_file.txt', 'w', 0755) do |f|
  count.each do |k,v|
    probability = Float(v) / Float(total_count)
    f.print "#{k}\t#{probability}\n"
  end
end

=begin
#擬似コード
create a map counts
create a variable total_count = 0
for each line in the training_file
 split line into an array of words
 append “</s>” to the end of words
 for each word in words
 add 1 to counts[word]
 add 1 to total_count

open the model_file for writing
for each word, count in counts
 probability = counts[word] / total_count
 print word, probability to model_file
=end
