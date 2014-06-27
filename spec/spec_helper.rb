ROOT_PATH = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift( File.join( ROOT_PATH, 'lib' ))

Dir[ROOT_PATH + '/support/**/*.rb'].each do |f|
  require f
end
