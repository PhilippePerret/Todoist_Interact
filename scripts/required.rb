=begin

À appeler en début de programme par tout script ruby

    require_relative 'required'

=end

PROJECT_FOLDER = File.expand_path('.')

FOLDER_RUBY = File.join(PROJECT_FOLDER, 'ruby')
FOLDER_CLASS_RUBY = File.join(FOLDER_RUBY, 'class')

# Dossiers à inclure
[
  "#{FOLDER_CLASS_RUBY}",
  "#{FOLDER_RUBY}/extensions"
].each do |dossier|
  Dir["#{dossier}/**/*.rb"].each{ |m| require m }
end
