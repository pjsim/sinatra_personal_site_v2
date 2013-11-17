require 'bundler'
Bundler.require

get '/' do
	@title = "Phillip Simmonds's Personal Site"
	slim :index	
end

__END__
### views ###

@@index
h1 HI