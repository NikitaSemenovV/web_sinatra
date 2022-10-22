require 'rake'
require 'dotenv/tasks'
require 'yaml'

namespace :db do
  require 'sequel'
  Sequel.extension :migration
  environment = ENV['RACK_ENV'] || 'development'
  conf = YAML.load_file 'config/database.yml', aliases: true
  migrations_directory = 'db/migrations'
  connection_string = ENV['DATABASE_URL'] ||
    "postgres://#{conf[environment]['username']}:#{conf[environment]['password']}@#{conf[environment]['host']}/#{conf[environment]['database']}"

  puts "database = #{conf[environment]['database'].inspect}"
  puts "connection_string = #{connection_string.inspect}"

  $db = Sequel.connect(connection_string)
  desc "Prints current schema version"
  task :version do
    puts "Sinatra::Application.settings = #{Sinatra::Application.settings.inspect}"
    puts "Sinatra::Application.environment = #{Sinatra::Application.environment.inspect}"
    puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV'].inspect}"
    puts "environment = #{environment.inspect}"
    puts "ENV['DATABASE_URL'] = #{ENV['DATABASE_URL'].inspect}"
    puts "db[:schema_info].first = #{$db[:schema_info].first.inspect}"
    version = if $db.tables.include?(:schema_info)
                $db[:schema_info].first[:version]
              end || 0
    puts "Schema Version: #{version}"
  end

  desc 'Run migrations up to specified version or to latest.'
  task :migrate, [:version] => [:dotenv] do |_, args|
    version = args[:version]
    raise "Missing Connection string" if connection_string.nil?
    # db = Sequel.connect(connection_string)
    message = if version.nil?
                Sequel::Migrator.run($db, migrations_directory)
                'Migrated to latest'
              else
                Sequel::Migrator.run($db, migrations_directory, target: version.to_i)
                "Migrated to version #{version}"
              end
    puts message if environment != 'test'
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, :target do |t, args|
    args.with_defaults(:target => 0)
    Sequel::Migrator.run($db, migrations_directory, :target => args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc "Perform migration reset (full rollback and migration)"
  task :reset do
    Sequel::Migrator.run($db, migrations_directory, :target => 0)
    Sequel::Migrator.run($db, migrations_directory)
    Rake::Task['db:version'].execute
    $db.drop_table?(:schema_seeds)
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :seed do
    require 'sequel/extensions/seed'
    puts 'seed task running'
    Sequel::Seed.setup :development # Set the environment
    Sequel.extension :seed # Load the extension
    Dir.glob("./models/*.rb", &method(:require))
    Sequel::Seeder.apply($db, './seeds') # Apply the seeds/fixtures
  end

end
