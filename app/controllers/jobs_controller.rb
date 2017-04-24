class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :join, :quit]
  before_action :validate_search_key, :only => [:search]


  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 10)
    when 'by_upper_bound'
      Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 10)
    else
      Job.published.recent.paginate(:page => params[:page], :per_page => 10)
    end
    @suggests = Job.published.random5
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:warning] = "工作已归档"
      redirect_to root_path
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, alert: "职位已经删除"
  end

  def join
    @job = Job.find(params[:id])

    if !current_user.is_member_of?(@job)
      current_user.join!(@job)
      flash[:notice] = '收藏职位成功'
    else
      flash[:warning] = '已经收藏了，请勿重复操作'
    end
    redirect_to job_path(@job)
  end

  def quit
    @job = Job.find(params[:id])

    if current_user.is_member_of?(@job)
      current_user.quit!(@job)
      flash[:alert] = '取消收藏成功'
    else
      flash[:warning] = '尚未收藏'
    end
    redirect_to job_path(@job)

  end

  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(distinct: true)
      @jobs = search_result.paginate(:page => params[:page], per_page: 15 )
      puts @jobs
    else
      @jobs = Job.publish.recent.paginate(page: params[:page], per_page: 15)
      puts @jobs
    end
  end

  private
    def validate_search_key
     @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
     @search_criteria = search_criteria(@query_string)
    end

   def search_criteria(query_string)
     { :title_or_description_or_contact_email_or_location_or_company_or_category_name_cont => query_string }
   end


   def job_params
     params.require(:job).permit(:title, :description,:wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :location, :company, :category)
   end
end
