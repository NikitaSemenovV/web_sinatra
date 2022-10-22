conf = YAML.load_file 'config/database.yml', aliases: true
@db = Sequel.connect(
  adapter: :postgres,
  database: conf[@environment]['database'],
  host: conf[@environment]['host'],
  user: conf[@environment]['username'],
  password: conf[@environment]['password'],
  max_connections: 10
)
