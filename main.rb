require 'bundler'
Bundler.require

configure do
  set :name, ENV['NAME'] || 'Phillip Simmonds'
  set :author, ENV['AUTHOR'] || 'Phillip Simmonds'
  set :analytics, ENV['ANALYTICS'] || 'UA-45970474-1'
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

get '/success' do
  @title = "Message Received!"
  slim :success
end

post '/' do
    require 'pony'
    Pony.mail(
      # from: "Phillip<phillip.j.simmonds@gmail.com>",
      from: params[:sender],
      to: 'phillip.j.simmonds@gmail.com',
      subject: "A message from the PJS website",
      body: params[:message],
      port: '587',
      via: :smtp,
      via_options: {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :enable_starttls_auto => true,
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :domain => 'heroku.com'
      })
    redirect '/success'
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


/p I am a web developer and 3D animator living in Sydney. I have skills in 
/p I have skills with Ruby on Rails, Sinatra and Python
/p I have skills Maya, Houdini and Nuke

p This site was built using the Sinatra framework with Twitter boostrap. The background image was done using Nodebox. 
p The code is available here on GitHub:
a href="https://github.com/pjsim/sinatra_personal_site_v2" target="_blank" github.com/pjsim/sinatra_personal_site_v2 


/hr
/p 
  /strong better content <-- do during work
/p built for mobile <-- menu needs to change based on mobile view
/p clean up code for github (including css)
/p new relic on my three sites
/p
 / strong githubs need updates!!!! all say 6 months ago!!

/p 
 / strong put github link in footer
/p 
 / strong github link this site -->

@@404
h1 404! 
p That page is missing

@@500
h1 500 Error! 
p Oops, something has gone terribly wrong!

@@success
p Thanks for the message, I'll be in touch soon.