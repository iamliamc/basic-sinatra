require 'yaml/store'
require 'sinatra'

get '/' do
  @title = 'Welcome to the LJC-Voter App!'    
  erb :index
end


post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end



Choices = {
  'BERN' => 'Bernie Sanders',
  'DON' => 'Donald Drumpf',
  'ELZ' => 'Elizabeth Warren',
  'CLIN' => 'Hillary Clinton',
  'JOHN' => 'Gary Johnson'
}