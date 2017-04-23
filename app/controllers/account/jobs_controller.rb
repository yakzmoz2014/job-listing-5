class Account::JobsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_is_not_admin

	def index
		@jobs = current_user.participated_jobs.paginate(:page => params[:page], :per_page => 15)
	end
end
