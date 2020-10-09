# == Schema Information
#
# Table name: rates
#
#  id           :integer          not null, primary key
#  abbreviation :string
#  name         :string
#  rate         :float
#  scale        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_rates_on_name  (name) UNIQUE
#
class Rate < ApplicationRecord 
  
  def self.fill_data
    data_clazz = Converter::DataFactory.for('web')       
    data = data_clazz.get_data(WEB_SOURCE)
    data.each do |cur, attr|
      Rate.create(
        abbreviation: cur, 
        name: attr['Cur_Name'],
        rate: attr['Cur_OfficialRate'],
        scale: attr['Cur_Scale']        
      )
    end
  end

  def self.load
    ActiveRecord::Base.transaction do
      Rate.delete_all
      Converter::DataUtils.get_raw_json(ENV['WEB_SOURCE']).each do |cur|
        Rate.create(
          name: cur['Cur_Name'],
          abbreviation: cur['Cur_Abbreviation'],
          scale: cur['Cur_Scale'],
          rate: cur['Cur_OfficialRate']
        )
      end
    end
  rescue ArgumentError, SocketError, Errno::ENOENT, JSON::ParserError => e
    puts(e)
  end
end
