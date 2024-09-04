require 'csv'

def generate_combinations(length = 3)
  characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'
  combinations = characters.chars.repeated_permutation(length).map(&:join)
  combinations
end

def save_to_csv(filename, combinations)
  CSV.open(filename, 'w') do |csv|
    combinations.each do |combo|
      csv << [combo]
    end
  end
end

def main
  combinations = generate_combinations
  save_to_csv('combinations.csv', combinations)
  puts "Generated #{combinations.size} combinations and saved to 'combinations.csv'."
end

main