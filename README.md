tag_parser
==========

This is a simple parser for strings with the below format:
  tag.1=value1 tag.2="value with spaces" a_different_tag=stuff tag

Some rules:
* Values with spaces, newlines or other whitespace need to be double-quoted.
* Values that contain double-quotes must have them escaped
* Unclosed double-quotes that have not been escaped are invalid
* No whitespace or quotes in tags

###Tag "Nesting"
Tags can contain "."s which have the effect of nesting the tags.
So for the message:
  tag.1=value1 tag.2=list tag.2.1=item1 tag.2.2=item2

You can imagine the message has an internal structure something like this:
  tag
    1=value1 
    2=list 
      1=item1 
      2=item2

Which means that you can iterate over any part of the structure like this:
  parser.structure_at("tag.2.").each do |tag, value|
    puts "tag : #{tag} value : #{value}"
  end

Usage
-----

### Initialization
  parser = TagParser.new 'tag.1=value1 tag.2="value with spaces" tag'

### Getting a Value by Tag Name
  parser.value_for "tag.1" #=> "value1"

Will only ever return one value. 

TODO If multiple identical tags exist the value for the last instance of the tag in the string will be returned

** Not implemented yet! **
### Iterate Over 


Why?
----
I use a similar format for messaging with certain third-party software. The Java libraries provided for handling these messages leave a lot to be desired so I decided to have a go at writing something myself. It seems like a good way to learn a little bit about parsing and state machines. 

"Wait a minute... why is this in Ruby?" I hear you ask. Well, partly because its easier to write than Java and partly because I want to improve my Ruby skills. Expect a Java version soon.
