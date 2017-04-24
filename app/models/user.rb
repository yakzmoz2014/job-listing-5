class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



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
