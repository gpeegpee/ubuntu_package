require 'json'

## What

# This file takes in a markdown file and converts any [codeblocks](http://daringfireball.net/projects/markdown/syntax#precode)
# into gists, then embeds the gists via JS.

# Watch out for Github rate limiting, via IP, this is not an authenticated request


# The first argument into the script should be the filename you want to convert
#
#     $ ruby gist_snippits.rb tmp.txt


file_name = ARGV.shift
output_file_name = "output_#{file_name}"


## This regex pulls out the code blocks, see below for explanation
code_block_regex = /(^\s*$\n|\A)(^(?:[ ]{4}|\t).*[^\s].*$\n?(?:(?:^\s*$\n?)*^(?:[ ]{4}|\t).*[^\s].*$\n?)*)/


STDOUT.flush # lets the working dots "." print on the same line like tests not 100% required


# this sends the content to github, to make a gist, returns JSON with the `html_url`. http://developer.github.com/v3/gists/#create-a-gist
def curl_to_github(content, options = {})
  response = `curl -s -H 'Content-Type: application/json' -X POST -d '#{gist_request(content, options)}' \
  https://api.github.com/gists `
  return JSON.parse(response)
end


# formats content to gist format that github can read. http://developer.github.com/v3/gists/#create-a-gist
def gist_request(content, options = {})
  {
    "public"      => "#{options[:public] || true}",
    "files"       => {
      "#{options[:name] || 'file.md'}" => {
        "content" => "#{content}"
      }
    }
  }.to_json
end



puts "Converting code blocks in #{file_name} to embedded gists"

# open given file, extract each code block and replace it with an embedded
File.open(file_name, "r") do |file|
  contents = file.read
  while code_match = contents.match(code_block_regex)
    print "."
    gist_response =  curl_to_github(code_match.to_s)
    puts gist_response["message"] if gist_response["message"] # display warning
    contents.sub!(code_block_regex, "\n\n<script src='#{gist_response["html_url"]}.js'></script>\n\n")
  end

  puts "\n\nWriting output to #{output_file_name}"
  File.open(output_file_name, "w") {|f| f.write(contents)}
  puts "Finished"
end



## Regexp explained from Stack Overflow http://stackoverflow.com/questions/8900213/using-regex-to-find-all-code-identified-with-4-spaces

# (^\s*$\n|\A)                                # Capt grp 1, block is preceeded by a blank line or begin of string
# (                                           # Begin "Capture group 2", start of pre/code block
#    ^(?:[ ]{4}|\t) .* [^\s] .* $ \n?            # First line of code block (note - lines must contain at least 1 non-whitespace character)
#    (?:                                         # Start "Optionally, get more lines of code"
#        (?: ^ \s* $ \n? )*                         # Many optional blank lines
#        ^(?:[ ]{4}|\t) .* [^\s] .* $ \n?           # Another line of code
#    )*                                          # End "Optionally, get more lines of code", do 0 or more times
# )
