class TransactionsController < ApplicationController
  
  before_filter :load_user
  
  def index
    
    puts "in index"
    puts "searching for: " + params[:search].to_s    
    @transactions = @user.transactions.search(@user.id, params[:search])
    
    respond_to do |format|
      format.html # index.html.erb
      format.js   # index.js.erb
    end
  end

  def create

    @transaction = @user.transactions.new(params[:transaction])
    
    respond_to do |format|
      if @transaction.save
        
        # save tags in this transaction.
        save_tags
        # remove tag content from transaction description
        @transaction.description = @transaction.description.gsub(/\#\w+/, "").strip
        @transaction.save
        
        format.html { redirect_to(@user, :notice => 'Transaction was successfully created.') }
        format.js
      else
        format.html { redirect_to(@user, :notice => 'Unable to create transaction.') }
        format.js { render 'failure.js.erb' }
      end
    end
  end
  
  def edit
    @transaction = @user.transactions.find(params[:id])
  end

  def update
    @transaction = @user.transactions.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        
        # save tags in this transaction.
        save_tags
        # remove tag content from transaction description
        @transaction.description = @transaction.description.gsub(/\#\w+/, "").strip
        @transaction.save
        
        format.html { redirect_to(@user, :notice => 'Transaction was successfully updated.') }
        format.js
      else
        format.html { render :action => "edit" }
        format.js { render 'failure.js.erb' }
      end
    end
  end

  def destroy
    @transaction = @user.transactions.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.js
    end
  end

  private
    def load_user
      @user = User.find(params[:user_id])
    end
    
    def save_tags
      taglist = @transaction.description.scan(/#\w+/)
      puts "tags for this transaction: " + taglist.to_s
      taglist.each do |t|
        # remove the hash symbol
        ((t.reverse!).chop!).reverse!
        
        # check if the tag has already been created by this user or not.
        tag = @user.tags.find(:first, :conditions => ["lower(tag_name) = ?", t.downcase])
        
        if tag.nil?
          # tag does not exist. create a new one.
          tag = @user.tags.create({ :tag_name => t, :user_id => @user.id })
        end
        
        # set up habtm association
        @transaction.tags << tag
      end
    end
      
end