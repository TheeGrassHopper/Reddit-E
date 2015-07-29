class CommentsController < ApplicationController
    before_action :find_link
    before_action :find_comment, only: [:edit, :update, :destroy]
    before_action  :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    
    @comment = @link.comments.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to link_path(@link), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to link_path(@link), notice: 'Must Add A Comment Below!!' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  

  def update
    respond_to do |format|
      if @comment.update(comment_params)
      format.html { redirect_to link_path(@link), notice: 'Comment was successfully updated.' }
      format.json { render :show, status: :created, location: @comment }
      else
                format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to link_path(@link), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_comment
      @comment = Comment.find(params[:id])

    end
    def find_link
      @link = Link.find(params[:link_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
