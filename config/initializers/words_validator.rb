class WordsValidator < ActiveModel::EachValidator
def validate_each(record, attribute, value)
  value.to_s.split(/ /).each do |x|
  @bad_words ||= File.read('badwords.txt').split
  if @bad_words.include?(x)
  x = x.to_s.gsub(/[\w\W]/,'*')
  record.errors[attribute] << (options[:message] || " contain bad word #{x} Please try another")

end
end
end
end
