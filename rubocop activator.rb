require 'fileutils'

# The file you want to run Rubocop on
original_file = '/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/Portfolio Tasks/9.1.2C Major Task Credit Level - M Text Music Player with Update/music_player_with_menu.rb'

# Step 1: Generate the corrected file name by adding "_corrected" before the extension
corrected_file = original_file.sub(/(\.rb)$/, '_corrected\1')

# Path to your custom .rubocop.yml file
config_file = '/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/.rubocop.yml'

# Check if the file exists before running Rubocop
if File.exist?(original_file)
  # Step 2: Copy the original file to the corrected file
  FileUtils.cp(original_file, corrected_file)

  # Step 3: Run Rubocop's auto-correct on the corrected file with the specific config file
  system("rubocop -A '#{corrected_file}' --config '#{config_file}'")

  puts "Auto-corrected version saved to #{corrected_file}"
else
  puts "Error: File does not exist at #{original_file}"
end