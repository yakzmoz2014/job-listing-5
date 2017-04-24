class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:digitalocean]


 def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.provider = auth.provider
       user.uid = auth.uid
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
     end
 end

  def admin?
    is_admin
  end

  def display_name
    if self.username.present?
      self.username
    else
      self.email.split("@").first
    end
  end

  def is_member_of?(job)
    participated_jobs.include?(job)
  end

  def join!(job)
    participated_jobs << job
  end

  def quit!(job)
    participated_jobs.delete(job)
  end


  has_many :resumes
  has_many :jobs
  has_many :job_relationships
  has_many :participated_jobs, through: :job_relationships, source: :job
end
