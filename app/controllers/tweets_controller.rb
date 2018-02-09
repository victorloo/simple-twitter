class TweetsController < ApplicationController  

  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @reply = Reply.new
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:success] = "Tweet successfully created"
      redirect_to tweets_path
    else
      flash[:error] = "Something went wrong"
      render tweets_path
    end
  end
  
  #讓tweets可以被喜歡
  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    @tweet.count_likes
    redirect_back(fallback_location: root_path)
  end

  #讓tweets可以取消喜歡
  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    @tweet.count_likes
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
