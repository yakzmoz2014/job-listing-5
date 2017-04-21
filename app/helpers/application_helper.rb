module ApplicationHelper
  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=wavetar"
  end

  def render_user_avatar(user, size)
    if user.avatar.present?
      user.avatar
    else
      avatar_url(user, size)
    end
  end

  def formatDate(time)
		time.strftime("%Y-%m-%d")
	end

	def formatDetailTime(time)
		time.strftime("%Y-%m-%d %H:%M:%S")
	end

end
