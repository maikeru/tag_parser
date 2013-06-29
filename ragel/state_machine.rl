require 'pp'
=begin
%%{

  machine simple_lexer;
  
  action add_to_buffer { push_to_buffer(@quoted_buffer, data, p) }
  action clear_buffer  { @quoted_buffer = "" }

  action add_to_tag_buffer { push_to_buffer(@tag_buffer, data, p) }
  action add_to_value_buffer { push_to_buffer(@value_buffer, data, p) }

  # An explicitly defined state machine
  quoted_value =
    start: (
        '"' @clear_buffer -> body
        ),
    body: (
        [\\] @add_to_buffer        -> escape |
        ["]                        -> final |
        (any-["\\]) @add_to_buffer -> body
        ),
    escape: (
        any @add_to_buffer -> body
        );
    
  assignment            = '=';
  identifier            = (alnum|[._\-])+ @add_to_tag_buffer;
  value                 = (any - [" ])+ @add_to_value_buffer;
  tag_with_quoted_value = identifier + assignment + quoted_value;
  tag_with_value        = identifier + assignment + value;
  tag_with_space        = identifier + space;
  tag_with_eof          = identifier;

  main := |*
          tag_with_value        => { save_buffers(:tag_with_value, tokens, @tag_buffer, @value_buffer) };
          tag_with_quoted_value => { save_buffers(:tag_with_quoted_value, tokens, @tag_buffer, @quoted_buffer) };
          tag_with_space        => { save_buffers(:tag_only, tokens, @tag_buffer) };
          tag_with_eof          => { save_buffers(:tag_only, tokens, @tag_buffer) };
          space;
  *|;

}%%
=end

class StateMachine

  # Ragel generated data
  %% write data;

  def self.save_buffers type, target_array, *parms
    target_array << { type => parms }
    clear_buffers
  end

  def self.clear_buffers
    @tag_buffer = ""
    @value_buffer = ""
    @quoted_buffer = []
  end

  def self.push_to_buffer(buffer, in_data, pointer)
    buffer << [ in_data[pointer] ].pack("c*").to_s
  end

  def self.run_lexer(data)
    @tag_buffer = ""
    @value_buffer = ""
    @qv = ""
    data = data.unpack("c*") if(data.is_a?(String))
    eof = data.length
    tokens = []

    # Initialize the ragel state machine (will be replaced with generated code)
    %% write init;  
    # execute the ragel state machine (will be replaced with generated code)
    %% write exec;

    tokens
  end
end
