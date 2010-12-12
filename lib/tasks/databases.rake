namespace :db do
  def mysqlargs
    db = Rails::Configuration.new.database_configuration[Rails.env]
    db_args = "-u #{db['username']} -h #{db['host']} #{db['database']}"

    password = db['password']
    db_args = "-p#{password} #{db_args}" if password

    db_args
  end

  desc 'Back up the database to the tmp/db directory.'
  task :backup do
    timestamp = Time.now.to_s(:number)
    backup = "#{Rails.root}/tmp/db/editions.#{Rails.env}.#{timestamp}.sql.gz"
    cmd = "mysqldump #{mysqlargs} | gzip > #{backup}"
    sh %{mkdir -p `dirname #{backup}` && (#{cmd})}
  end

  desc "Print a database dump to the standard output."
  task :mysqldump do
    sh "mysqldump #{mysqlargs}"
  end
end
