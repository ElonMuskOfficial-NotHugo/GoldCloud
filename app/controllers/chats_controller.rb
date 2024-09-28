class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @chats =  Chat.joins(:messages)
                    .group('chats.id')
                    .order('MAX(messages.created_at) DESC')
    else
      @chats = current_user.chats.joins(:messages)
                          .group('chats.id')
                          .order('MAX(messages.created_at) DESC')
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(timestamp: :asc)
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    if current_user.admin?
      @chat.destroy
      redirect_to chats_path, notice: 'Chat was successfully ended.'
    else
      redirect_to @chat, alert: 'You do not have permission to end this chat.'
    end
  end


  private

  def chat_params
    params.require(:chat).permit(:title)
  end
end
