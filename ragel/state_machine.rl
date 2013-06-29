require 'pp'
=begin
%%{

  machine simple_lexer;
  
  action add_to_buffer { push_to_buffer(@quoted_buffer, data, p) }
  action clear_buffer  { @quoted_buffer = "" }
  action print_buffer  { pp @quoted_buffer }

  action add_to_tag_buffer { push_to_buffer(@tag_buffer, data, p) }
  action add_to_value_buffer { push_to_buffer(@value_buffer, data, p) }

  # An explicitly defined state machine
  quoted_value =
    start: (
        '"' @clear_buffer -> body
        ),
    body: (
        [\\] @add_to_buffer -> escape |
        ["] @print_buffer -> final |
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
          tag_with_value        => { emit(:tag_with_value, data, token_array, ts, te); save_buffers(:tag_with_value, token_array2, @tag_buffer, @value_buffer) };
          tag_with_quoted_value => { emit(:tag_with_quoted_value, data, token_array, ts, te); save_buffers(:tag_with_quoted_value, token_array2, @tag_buffer, @quoted_buffer) };
          tag_with_space        => { emit(:tag_with_space, data, token_array, ts, te); save_buffers(:tag_only, token_array2, @tag_buffer) };
          tag_with_eof          => { emit(:tag_with_eof, data, token_array, ts, te); save_buffers(:tag_only, token_array2, @tag_buffer) };
          space;
  *|;

}%%
=end

%% write data;

def emit(token_name, data, target_array, ts, te)
  #pp [token_name, data, target_array, ts, te]

  target_array << {:name => token_name.to_sym, :value => data[ts...te].pack("c*") }
end

def save_buffers type, target_array, *parms
  target_array << { type => parms }
  clear_buffers
end

def clear_buffers
  @tag_buffer = ""
  @value_buffer = ""
  @quoted_buffer = []
end

def push_to_buffer(buffer, in_data, pointer)
  #puts "in_data #{in_data}"
  #puts "pointer #{pointer}"
  buffer << [ in_data[pointer] ].pack("c*").to_s
end

def run_lexer(data)
  @tag_buffer = ""
  @value_buffer = ""
  @qv = ""
  data = data.unpack("c*") if(data.is_a?(String))
  eof = data.length
  token_array = []
  token_array2 = []
  
  %% write init;
  %% write exec;

  #puts token_array.inspect
  #pp token_array
  #puts "========================"
  #pp token_array2
  token_array2
end

puts "running..."
message = "do=command data.1=10 data.2=\"we have spaces\" mytag data.3=\"and \nnewlines!\" random=stuff data.4=\"value with \\\"escaped quotes\\\"\" all_alone "
puts "message [#{message}]"
run_lexer(message)
puts "finished..."
