=begin

Usage:

**Requires Ruby to be installed**

In a terminal window run a similar command

  Example usage
ruby histogram.rb ../../../writings/reviews/2020_yearly.md ../../../writings/reviews/yearly_template.md 

  With template:
ruby histogram.rb path/to/input_file path/to/template_file

  Without template:
ruby histogram.rb path/to/input_file

=end

input_file_word_count = Hash.new(0)
template_word_count = Hash.new(0)

INPUT_FILENAME = ARGV[0]
TEMPLATE_FILENAME = ARGV[1] || nil

EN_STOP_WORDS = %w(
  a about above after again against all already also although am an and any are aren't as at be because been before being below between bit both but by can't cannot could couldn't did didn't do does doesn't doing don't down during each even few for from further had hadn't has hasn't have haven't having he he'd he'll he's her here here's hers herself him himself his how how's i i'd i'll i'm i've if in into is isn't it it's its itself let's many me more most much mustn't my myself no none nor not of off on once only or other ought our ours ourselves out over own really same shan't she she'd she'll she's should shouldn't so some such than that that's the their theirs them themselves then there there's these they they'd they'll they're they've this those through to too under until up us very was wasn't we we'd we'll we're we've were weren't what what's when when's where where's which while who who's whom why why's with won't would wouldn't you you'd you'll you're you've your yours yourself yourselves
)

def build_histogram_hash(filename, hash)
  if filename
    File.open(filename, "r") do |f|
      f.each_line do |line|
        line.split(' ').each do |word|
          hash[word.downcase] += 1
        end
      end
    end
  end
end

def filter_out_stop_words(input_file_word_count)
  EN_STOP_WORDS.each do |k|
    input_file_word_count.delete(k)
  end
end

def filter_non_alpha_keys(input_file_word_count)
  input_file_word_count.reject! do |key, value| 
    key.match?( /[^a-zA-Z]/ )
  end
end

def filter_template_counts(template_word_count, input_file_word_count)
  template_word_count.each do |k,v|
    input_file_word_count[k] -= v if input_file_word_count[k]
  end
end

def format_pairs(k, v)
  "#{k}: #{v}\n"
end

def output_to_file(output_hash)
  new_filename = "#{File.dirname(INPUT_FILENAME)}/#{File.basename(INPUT_FILENAME, ".*")}_counts.txt"

  File.open(new_filename, "w+") do |f|
    output_hash.sort_by { |k, v| -v }.each do |k,v|
      f << format_pairs(k, v) if v > 0
    end
  end
end

def print_to_screen(output_hash)
  counter = 0
  title = "****** Top 20 keywords ******"
  
  puts
  puts title
  puts

  output_hash.sort_by { |k, v| -v }.each do |k, v|
    break if counter == 20

    puts "#{counter + 1}) #{format_pairs(k, v)}" if v > 0
    counter += 1
  end

  puts
end

### Runner ###

build_histogram_hash(TEMPLATE_FILENAME, template_word_count)
build_histogram_hash(INPUT_FILENAME, input_file_word_count)

filter_out_stop_words(input_file_word_count)
filter_non_alpha_keys(input_file_word_count)
filter_template_counts(template_word_count, input_file_word_count)

output_to_file(input_file_word_count)
print_to_screen(input_file_word_count)
