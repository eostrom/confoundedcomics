application = "comics.confoundedcontraption.com"
repository = 'git://github.com/eostrom/confoundedcomics.git'
hosts = ['comics.confoundedcontraption.com']

#this are set by default

path = '/home/confoundedcomics'
user = 'confoundedcomics'

#ssh_opts = ''
#branch = 'master'
#sudo = false
#cache_dirs = %w(public/cache)
#skip_steps = nil

before_restarting_server do
  rake "RAILS_ENV=#{environment} hobo:generate_taglibs"
end
