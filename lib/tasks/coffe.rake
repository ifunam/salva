namespace :coffee do
  task :compile, :filename do |t, args|
    filename = args.filename
    puts CoffeeScript.compile(File.open(filename))
  end
end
