class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	before_action :require_user, only: [:edit, :update]
	before_action :require_same_user, only: [:edit, :update]

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 3)
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 3)
	end

	def new
		@user = User.new #Create new user in database
	end

	def edit
		end

	def update
				if @user.update(user_params)
			flash[:notice] = "Your account info was updated"
			redirect_to @user #short for user path which require an object
		else
			render 'edit'
		end
	end	



	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
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

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user && !current_user.admin?
		flash[:alert] = "You can only edit your own account"
		redirect_to @user
	end
	end

end