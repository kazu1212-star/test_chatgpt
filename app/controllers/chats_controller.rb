# frozen_string_literal: true

class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      response_message = OpenAi.generate(@chat.text)
      @chat.update(response_message: response_message)
      redirect_to @chat
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:text)
  end
end
