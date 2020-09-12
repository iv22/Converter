class Converter
    include ActiveModel::Validations

    validates :type, presence: true
    validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :from, presence: true
    validates :to, presence: true
    validates_with ConverterValidator
    
    attr_accessor :type, :amount, :from, :to

    WEB_SOURCE = 'https://www.nbrb.by/api/exrates/rates?periodicity=0'
    FILE_PATH = Rails.root.join('app', 'storage')

    def initialize(params = {})
      params.each {|name, value| send("#{name}=", value)}     
    end

    def call(params)            
      data_source = params[:type] == 'web' ? WEB_SOURCE : "#{FILE_PATH}/data.#{params[:type]}"
      data_clazz = Converter::DataFactory.for(params[:type])       
      con = Converter::CurrencyConverter.new(data_clazz.get_data(data_source))
      # byebug
      con.convert(params[:amount].to_i, params[:from], params[:to])[1].cents
    end
end
