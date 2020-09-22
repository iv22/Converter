class ConverterController < ApplicationController

  def index    
    @converter = Converter.new     
  end

  def convert
    @params = params.require(:converter).permit(:type, :amount, :from, :to)    
=begin
    respond_to do |format|
      format.js 
    end
=end
    @converter = Converter.new(@params)
    if @converter.valid?
      @result = @converter.call(@params) 
    else
      @result = @converter.errors.messages.inject('') {|out, msg| out + msg[1].join(' | ') + '\n' }
    end 
    ActionCable.server.broadcast('currency_news', result: @result, time: Time.current)
  end
end
