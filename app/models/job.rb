class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: {greater_than: 0}
  validates :category_name, presence: true
  validates :location, presence: true
  validates :company, presence: true
  validates :contact_email, presence: true


  scope :recent, -> {order("created_at DESC")}
  scope :published, -> { where(is_hidden: false) }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  has_many :resumes
  has_many :job_relationships
  has_many :members, through: :job_relationships, source: :user
end
