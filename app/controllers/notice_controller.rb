class NoticeController < ApplicationController
  def index
    @notice = Notice.all
  end
  
  def create
  end
  
  def create_new
    notice_new = Notice.new
    notice_new.nickname = params[:nickname]
    notice_new.password = params[:pw]
    notice_new.title = params[:title]
    notice_new.phone = params[:num]
    notice_new.content = params[:content]
    notice_new.save
    redirect_to "/notice/index"
  end
  
  def show
    @post = Notice.find(params[:post_num])
  end
  
  def update_view
     @post = Notice.find(params[:post_num])
  end
  
  def update
    notice_update = Notice.find(params[:post_num])
    notice_update.nickname = params[:nickname]
    notice_update.password = params[:pw]
    notice_update.title = params[:title]
    notice_update.phone = params[:num]
    notice_update.content = params[:content]
    notice_update.save
    redirect_to "/notice/show/"+ params[:post_num] 
  end
  
  def destroy
    notice_destroy = Notice.find(params[:post_num])
    notice_destroy.destroy
    redirect_to "/notice/index"
  end
  
end
