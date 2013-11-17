require 'bundler'
Bundler.require

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

get '/' do
	@title = "Phillip Simmonds's Personal Site"
	slim :index	
end

__END__
### views ###

@@index
ul#myTab.nav.nav-tabs
	li.active
    	a href="#home" Home
  	li
    	a href="#profile" Profile
  	li
    	a href="#messages" Messages
  	li
    	a href="#settings" Settings
.tab-content
 	#home.tab-pane.active ...dsads
  	#profile.tab-pane ...asddsaad
  	#messages.tab-pane ...adsdsaewq
  	#settings.tab-pane ...eqwwqe

javascript:
	| $('#myTab a').click(function (e) {
	| e.preventDefault();
	| $(this).tab('show');
	| })