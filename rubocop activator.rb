require 'fileutils'

# The file you want to run Rubocop on
original_file = '/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/Portfolio Tasks/9.3D M 📙 🖊 Gosu Shape Moving /shape_moving.rb'

# Step 1: Generate the corrected file name by adding "_corrected" before the extension
corrected_file = original_file.sub(/(\.rb)$/, '_corrected\1')

# Check if the file exists before running Rubocop
if File.exist?(original_file)
  # Step 2: Run Rubocop's auto-correct
  system("rubocop -A '#{original_file}'")

  # Step 3: Copy the corrected file to the new file
  FileUtils.cp(original_file, corrected_file)

  # Step 4: Restore the original file (if it's inside the Git repo)
  git_restore_status = system("git ls-files --error-unmatch '#{original_file}' > /dev/null 2>&1")
  if git_restore_status
    system("git checkout -- '#{original_file}'")
  else
    puts "File is not tracked by Git. No restore possible."
  end

  puts "Auto-corrected version saved to #{corrected_file}"
else
  puts "Error: File does not exist at #{original_file}"
end