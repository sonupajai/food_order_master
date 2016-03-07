class UserNotifier < ApplicationMailer
	default :from => "foodorder247@gmail.com"

	def welcome_email(user)
		@user = user
		mail(:to => @user.email,
			 :subject => "Thanks for signing up for Food Order app.")
	end
end
