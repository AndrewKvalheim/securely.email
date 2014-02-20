desc 'Deploy to Heroku'
task :deploy do
  toplevel = `git rev-parse --show-toplevel`.chomp

  Dir.chdir toplevel do
    `git push heroku master`
  end
end
