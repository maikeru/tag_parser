require 'tokenizer'
class TagParser
  def initialize input
    @tokens = Tokenizer.new(input).tokens
    @key_value ||= token_to_key_value
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
    #Hash[@key_value.map { |k, v| [k.sub(path, "").to_sym, v] } ]
    tags = Hash.new
    each_match path do |key, value|
      tags[to_relative(key, path)] = value
    end
    tags
  end

  private

  def each_match path
    @key_value.each do |key, value|
      if key.match('^' + path)
        yield key, value
      end
    end
  end

  def to_relative full, to_trim
    full.sub(to_trim, "").to_sym
  end

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
