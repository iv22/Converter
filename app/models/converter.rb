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
      con = Converter::CurrencyConverter.new(get_data(params[:type]))
      # byebug
      result = con.convert(params[:amount].to_i, params[:from], params[:to])
      result = "#{ result[1].cents } cents | #{ con.format_convert(*result) }"
    end    

    def get_data(type)
      if type == 'DB'
        result = {}
        Rate.all.each {|cur| result[cur.abbreviation] = {
          'Cur_Scale' => cur.scale, 
          'Cur_name' => cur.name,
          'Cur_OfficialRate' => cur.rate}}
        result
      else  
        data_source = type == 'web' ? WEB_SOURCE : "#{FILE_PATH}/data.#{type}"
        data_clazz = Converter::DataFactory.for(type)
        data_clazz.get_data(data_source)
      end
    end
end
