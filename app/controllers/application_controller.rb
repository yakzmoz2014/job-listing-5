class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      redirect_to root_path, alert: "你不是管理员"
    end
  end

  def require_is_not_admin
    if current_user.admin?
      flash[:alert] = '管理员不能进行此操作'
      redirect_to jobs_path
    end
  end
end
