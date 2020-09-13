class ConverterController < ApplicationController

  def index    
  end

  def convert
    @params = params.permit(:type, :amount, :from, :to)    
    p @params 
    respond_to do |format|
      format.js 
    end
    
    @converter = Converter.new(@params)
    if @converter.valid?
      @result = @converter.call(@params)
    else
      @result = @converter.errors.messages
    end 
  end
end
