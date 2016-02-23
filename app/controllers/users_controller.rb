class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	def index
	  @users = User.all
	  @users = User.order(name: :asc).page(params[:page]).per(5)

	end

	def edit

	end

	def update
		@user.update(user_params)
		respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end
	def show

	end

	private
		def set_user
			@user = User.find(params[:id])
		end

		def user_params
      params.require(:user).permit(:role)
    end
end
