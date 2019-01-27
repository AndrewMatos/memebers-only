class PostsController < ApplicationController
   before_action :authorize, only:[:new, :create] 
   
   def new
   end

   def create
	   if put_post
	   	redirect_to posts_url
	   else
	   	flash.now[:danger] ="post couldn't be created"
	   	render "new"
	   end
   end

   def index
   	@posts = Post.all
   end

   private

   def posts_params
        params.require(:posts).permit(:body)
   end

   def user_id
   	{user_id: current_user.id}
   end

   def put_post
   	post = Post.new(posts_params.merge(user_id))
    post.save
   end
end
