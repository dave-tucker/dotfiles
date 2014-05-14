#!/usr/bin/env ruby
require 'time'
require 'erb'
require 'cgi'

filename = "~/.gitlogger"
## File format, One per line
# Repo Name:/path/to/base
dayone = true # log to day one? (true or false)
textlog = "~/Dropbox/Notes/GitLogger.md"

git_user = %x{git config --get user.name}.strip
git_user = ENV['GIT_AUTHOR_NAME'] if git_user == ''
git_user = '.' if git_user == ''

entrytext = ""

File.open(File.expand_path(filename), 'r') do |infile|
  while (line = infile.gets)
    name, path = line.strip.split(':')
    Dir.chdir(path)

    repo_log = ''
    repo_log = %x{git log --first-parent --no-merges --author="#{git_user}" --pretty=format:"%%NEWLINE**[#{name}]** %%%ct%%: %s (%h)%n    %+b%n" --since="yesterday"}.gsub(/%(\d+)%/) { |timestamp|
      timestamp.gsub!(/%/,'')
      Time.at(timestamp.to_i).strftime("%H:%M").gsub(/^0/,'')
    }
    # if no remote repository is specified, `git fetch` will output
    # error messages;  so we silence them
    repo_log = %x{git fetch 2>/dev/null && git log --remotes --first-parent --no-merges --author="#{git_user}" --pretty=format:"* **[#{name}]** %%%ct%%: %s (%h)%n    %+b%n" --since="yesterday"}.gsub(/%(\d+)%/) { |timestamp|
      timestamp.gsub!(/%/,'')
      Time.at(timestamp.to_i).strftime("%H:%M").gsub(/^0/,'')
    } if repo_log == ''
    entrytext += repo_log
  end
end

exit if entrytext.strip == ""

# remove the weird empty lines at the beginning
entrytext = entrytext.gsub(/^\s{4}\n/,"").gsub(/\n{3,}/m,"\n\n")

entries = entrytext.split('%NEWLINE')
output = []

# the first line is always empty gibberish and will be omitted
entries[1..-1].each do |entry|
  entry.gsub!(/^(.+)$/, '    \1')
  entry[0] = "*"
  output << entry
end
entrytext = output.join
entrytext << "\n"

if dayone
  uuid = %x{uuidgen}.gsub(/-/,'').strip
  datestamp = Time.now.utc.iso8601
  starred = false

  dayonedir = %x{ls ~/Library/Mobile\\ Documents/|grep dayoneapp}.strip
  dayonepath = "~/Dropbox/Apps/Day\ One/Journal.dayone/entries/"
  #"~/Library/Mobile\ Documents/#{dayonedir}/Documents/Journal_dayone/entries/"
  entry = CGI.escapeHTML("Git Log #{Time.now.strftime("%Y-%m-%d")}:\n\n#{entrytext}")
  template = ERB.new <<-XMLTEMPLATE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Creation Date</key>
  <date><%= datestamp %></date>
  <key>Entry Text</key>
  <string><%= entry %></string>
  <key>Starred</key>
  <<%= starred %>/>
  <key>UUID</key>
  <string><%= uuid %></string>
</dict>
</plist>
XMLTEMPLATE

  fh = File.new(File.expand_path(dayonepath+uuid+".doentry"),'w+')
  fh.puts template.result(binding)
  fh.close
  # puts "ENTRY ADDED"
  # puts "------------------------"
  # puts "Time:    " + datestamp
  # puts "UUID:    " + uuid
  # puts "Starred: " + starred.to_s
  # puts "Entry:   " + entrytext
end

if textlog
  entry = "---\n\n### #{Time.now.strftime("%D")}:\n\n#{entrytext}"
  open(File.expand_path(textlog), 'a') { |f|
    f.puts entry
  }
end
