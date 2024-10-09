require 'fileutils'

# Define the directory path you want to rename files in
directory_path = '/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/Portfolio Tasks/9.1.3D Major Task Distinction Level - M GUI Music Player/music_files/Another_Friday_Night'

# Define the recursive renaming method
def rename_files_with_underscores(directory)
  # Find all files and directories within the specified directory
  Dir.glob(File.join(directory, '**', '*')).each do |file|
    # Skip if it's a directory
    next if File.directory?(file)

    # Get the new file name by replacing spaces with underscores
    new_file = file.gsub(' ', '_')

    # Skip if the file name is the same (no spaces)
    next if file == new_file

    # Rename the file, preserve file path by moving if necessary
    FileUtils.mv(file, new_file)
  end
end

# Call the method to start renaming process
rename_files_with_underscores(directory_path)

puts "Files have been renamed."