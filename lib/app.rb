module MyApp
end

# require each entity, script, and database, AND require 
# that each of these files require app.rb. This makes sure
# that all entities, scripts, and database files can talk
# and listen to each other. 

# require_relative '.app/database/...'
# require_relative '.app/entities/...'
# require_relative '.app/scripts/...'

