require 'bigdecimal'
require 'bigdecimal/util'

probabilities = {}
model_file = 'model_file.txt'

File.open(model_file, 'r') do |f|
  while (line = f.gets) do
    word, prob = line.split(' ')
    probabilities[word] = prob.to_f
  end
end

=begin
# 擬似コード（モデル読み込み）
create a map probabilities
for each line in model_file
 split line into w and P
 set probabilities[w] = P
=end

lambda1 = 0.95
lambda_unk = 0.05
v = 1000000
w = 0
h = 0
unknown = 0
test_file = '../data/wiki-en-test.word'

File.open(test_file, 'r') do |f|
  words = []
  while (line = f.gets) do
    words.push(*line.split(' '))
    words.push('</s>')
  end
  words.each do |word|
    w += 1
    p = BigDecimal(lambda_unk.to_s) / BigDecimal(v.to_s)
    if probabilities[word]
      p += BigDecimal(lambda1.to_s) * BigDecimal(probabilities[word].to_s)
    else
      unknown += 1
    end
    h += Math.log(p, 2).abs
  end
end

puts "entropy = #{BigDecimal(h.to_s)/BigDecimal(w.to_s)}"
puts "coverage = #{(w-unknown)/Float(w)}"


=begin
# 擬似コード（評価と結果表示）
for each line in test_file
 split line into an array of words
 append “</s>” to the end of words
 for each w in words
  add 1 to W
  set P = λunk / V
  if probabilities[w] exists
    set P += λ1 * probabilities[w]
  else
  add 1 to unk
 add -log2P to H

print “entropy = ”+H/W
print “coverage = ” + (W-unk)/W
=end
