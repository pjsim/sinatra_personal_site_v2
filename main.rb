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

p better content <-- do during work
p built for mobile <-- menu needs to change based on mobile view
p use stackoverflow for everything you dont know
p weta wants: scrum, MySQL, (say i use postgres but its similar), i will pop by in april. 
p my dad is NZ born and having family reunion
p whats on front page ==> short about me? skills? pics?
p clean up code for github (including css)
p probably move menu right a bit and give bit more space to main content (esp 3d vids)
p favicon
p keep logo or not?
p just sum up the about me in the main page
p say on main page and about me what sklls most familiar with: ruby, rails, maya, houdini, nuke
p fix title phills personal page
p cv needs special titles or better yet make it look more like real CV
p have download pdf cv option!!
@@404
h1 404! 
p That page is missing

@@500
h1 500 Error! 
p Oops, something has gone terribly wrong!

@@success
p Thanks for the message, I'll be in touch soon.