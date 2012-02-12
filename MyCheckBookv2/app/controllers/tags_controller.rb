class TagsController < ApplicationController

  before_filter :load_user

  def index
    @tags = @user.tags.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @user = User.find(params[:user][:id])
    @tag = @user.tags.find(params[:tag])
  end

  def create
    @tag = @user.tags.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to(@user, :notice => 'New tag was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @tag = @user.tags.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(@tag, :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag = @user.tags.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_user
      if session[:user_id].nil?
        redirect_to root_path, :notice => 'Session timed out. Please login again.'
      end
      @user = User.find(session[:user_id])  
    end
    
  
end
