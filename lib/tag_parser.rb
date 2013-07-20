require 'tokenizer'
class TagParser
  def initialize input
    @tokens = Tokenizer.new(input).tokens
  end

  def value_for tag
    @tokens.each do |token|
      token.each do |token_type, token_content|
        if token_content[0] == tag
          return token_content.fetch(1, "")
        end
      end
    end
    raise Exception
  end

  def tags_at path
    @key_value ||= token_to_key_value
    temp = Hash.new
    @key_value.each do |key, value|
    #@key_value.select do |key, value|
      # if matches search path
      if key.match('^' + path)
        reduced_key = key.sub(path, "").to_sym
        temp[reduced_key] = @key_value[key]
      end
    end
    temp
  end

  private

  # Maintains tag order in ruby 1.9.x not sure if its good to depend on this
  def token_to_key_value
    key_value = Hash.new
    @tokens.each do |token|
      token.each do |token_type, token_content|
        key_value[token_content[0]] = token_content.fetch(1, "")
      end
    end
    key_value
  end
end
