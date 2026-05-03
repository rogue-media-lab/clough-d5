class Admin::ContactMessagesController < Admin::BaseController
  before_action :set_message, only: [ :show, :mark_read, :mark_replied, :destroy ]

  def index
    @messages = ContactMessage.unread_first.recent
    @unread_count = ContactMessage.unread.count
  end

  def show
    @message.mark_as_read!
  end

  def mark_read
    @message.mark_as_read!
    redirect_to admin_contact_messages_path, notice: "Marked as read."
  end

  def mark_replied
    @message.mark_as_replied!
    redirect_to admin_contact_messages_path, notice: "Marked as replied."
  end

  def destroy
    @message.destroy
    redirect_to admin_contact_messages_path, notice: "Message deleted."
  end

  private

  def set_message
    @message = ContactMessage.find(params[:id])
  end
end
