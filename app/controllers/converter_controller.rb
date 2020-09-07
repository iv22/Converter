class ConverterController < ApplicationController
  def index
  end

  def convert
    @params = params.permit(:type, :amount, :from, :to)    
    
    respond_to do |format|
      format.js 
    end
    
    converter = ConverterCaller.new(@params)
    if converter.valid?
      @result = converter.call(@params)
    else
      @result = converter.errors.messages[:base]
    end 
  end
end
