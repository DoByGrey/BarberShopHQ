#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: 'barbershop.db' }

class Client < ActiveRecord::Base 
	validates :name, presence: true, length: { minimum: 3 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end	

class Barber < ActiveRecord::Base
end	

class Contact < ActiveRecord::Base
end	

before do
	@barbers = Barber.all
end	

get '/' do
	@barbers = Barber.order "created_at Desc"
	erb :index
end

get '/about' do
	erb :about
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Спасибо, вы  записались!</h2>"
	else	
		@error = @c.errors.full_messages.first
		erb :visit
	end	
	# простой способ
	#@user_name = params[:username]
	#@phone 		 = params[:phone]
	#@datetime  = params[:datetime]
	#@master		 = params[:master]
	#@color		 = params[:color]
	# Сохранение в БД с помощью ActiveRecord
	#clnt = Client.new
	#clnt.name = @user_name
	#clnt.phone = @phone
	#clnt.datestamp = @datetime
	#clnt.barber = @master
	#clnt.color = @color
	#clnt.save
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@user_email = params[:user_email]
	@message = params[:message]

	# Сохранение в БД с помощью ActiveRecord
	c = Contact.new
	c.user_email = @user_email
	c.message = @message
	c.save
  
	erb "<h3>Сообщение отправлено!</h3>"
end	

get '/barber/:id' do
	erb :barber
end	