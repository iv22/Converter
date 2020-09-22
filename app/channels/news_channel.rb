class NewsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "currency_news"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
