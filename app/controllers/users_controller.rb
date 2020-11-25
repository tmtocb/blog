class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])  #This will find-out an user based on the id in user table
	end

	def update
		@user = User.find(params[:id])
			if @user.update(user_params)
			flash[:notice] = "Your account info was updated"
			redirect_to articles_path
		else
			render 'edit'
		end
	end	



	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to My Blog #{@user.username}, you have signed-up!"
			redirect_to articles_path
		else
			render 'new'
		end	
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

end