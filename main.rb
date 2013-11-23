require 'bundler'
Bundler.require

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  set :styles, %w[ main ]
end

helpers do
  def styles
    styles = ""
    (@styles?([@styles].flatten+settings.styles):settings.styles).uniq.each do |style|
      styles << "<link href=\"/#{style}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end
    styles
  end
end

### Routes ###
not_found { slim :'404' }
error { slim :'500' }
get('/main.css') { scss :styles }


get '/' do
	@title = "Phillip Simmonds's Personal Site"
	slim :index
end

get '/:page' do
  if File.exists?('views/'+params[:page]+'.slim')
    slim params[:page].to_sym
  elsif File.exists?('views/'+params[:page]+'.md')
    markdown params[:page].to_sym
  else
    raise error(404) 
  end   
end

__END__
### views ###

@@index
.css3-notification
  p Hi, this website is under development!!
p It still needs google analytics and SOE, image optimisation, CSS optimisation
p working form, better content
p built for mobile
p links for things like company names
p link crazy domain to heroku  
@@404
h1 404! 
p That page is missing

@@500
h1 500 Error! 
p Oops, something has gone terribly wrong!