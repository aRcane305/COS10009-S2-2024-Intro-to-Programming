require 'find'
require 'fileutils'

txt_file = File.open("ogg_files.txt", "w")

Find.find('.') do |path|
  if path.end_with?('.ogg')
    file_name = File.basename(path, '.ogg')
    file_name_chomped = file_name.sub(/^\d+ - */, '')
    file_dir = '/music files/ASTROWORLD'+ File.dirname(path).sub(/^\./, '')
      txt_file.puts "#{file_name_chomped}\n#{File.join(file_dir, file_name)}.ogg"
  end
end

txt_file.close