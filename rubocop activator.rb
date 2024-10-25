require 'fileutils'

# The file you want to run RuboCop on
original_file = '/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/Portfolio_Tasks/9.1.3D_Major_Task_Distinction_Level_-_M_GUI_Music_Player/gui_music_player.rb'

# Step 1: Generate the corrected file name by adding "_corrected" before the extension
corrected_file = original_file.sub(/(\.rb)$/, '_corrected\1')

# Path to your custom .rubocop.yml file
config_file = '/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/.rubocop.yml'

# Check if the file exists before running RuboCop
if File.exist?(original_file)
  # Step 2: Copy the original file to the corrected file
  FileUtils.cp(original_file, corrected_file)

  # Step 3: Run RuboCop's auto-correct on the corrected file with the specific config file
  rubocop_command = "rubocop -A '#{corrected_file}' --config '#{config_file}'"
  rubocop_result = system(rubocop_command)

  # Check if RuboCop executed successfully
  if rubocop_result
    puts "Auto-corrected version saved to #{corrected_file}"
  else
    puts "Error: RuboCop failed to execute the command: #{rubocop_command}"
  end
else
  puts "Error: File does not exist at #{original_file}"
end