namespace :slurp do
  desc "TODO"
  task categories: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "categories.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    
    csv.each do |row|
      t = Category.new
      t.name = row["category"]
      t.save

      puts "#{t.name} saved"
    end
    puts "There are now #{Category.count} rows in the categories table."
  end

end
