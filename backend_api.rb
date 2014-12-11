require 'savon'
require 'json'

class AEE_API
	def get_lista
		aee_client = Savon.client(wsdl: 'http://wss.prepa.com/services/BreakdownReport?wsdl')
		breakdownSummary = aee_client.call(:get_breakdowns_summary)
	 	hashtable = breakdownSummary.body
		pueblos = Array.new

		hashtable.each do |key, value|
			cantidad_de_pueblos = value[:return].length
			for cada_pueblo in 1..cantidad_de_pueblos
				cada_pueblo -= 1
				pueblos.push value[:return][cada_pueblo][:r1_town_or_city]
			end
		end
		return pueblos.to_json
	end

	def pueblo_especifico(pueblito)
		aee_client = Savon.client(wsdl: 'http://wss.prepa.com/services/BreakdownReport?wsdl')
		breakdownstuff = aee_client.call(:get_breakdowns_by_town_or_city, message: { "townOrCity" => pueblito.upcase })
		
		hash_table = breakdownstuff.body
		hash_pueblo = Hash.new
		hash_averia = Hash.new
		hash_array_averias = Array.new

		hash_table.each do |key, value|
			cantidad_averias_pueblo = value[:return].length
			# Checks if its an array of hashes or a hash
			if value[:return].kind_of?(Array)
				for averias in 1..cantidad_averias_pueblo
					averias -= 1
					hash_averias = Hash.new
					hash_averias["Area:"] = value[:return][averias][:r2_area]
					hash_averias["Status:"] = value[:return][averias][:r3_status]
					hash_averias["Last Update:"] = value[:return][averias][:r4_last_update]
					hash_array_averias[averias] = hash_averias
				end
				hash_pueblo["#{value[:return][averias][:r1_town_or_city]}"] = hash_array_averias
			else
				hash_averia["Area:"] = value[:return][:r2_area]
				hash_averia["Status:"] = value[:return][:r3_status]
				hash_averia["Last Update:"] = value[:return][:r4_last_update]
				hash_pueblo["#{value[:return][:r1_town_or_city]}"] = hash_averia
			end
		end
		return hash_pueblo.to_json
	end

	def all_averias
		aee_url = 'http://wss.prepa.com/services/BreakdownReport?wsdl'
		pueblos = Array.new
		hash_pueblo = Hash.new
		hash_averia = Hash.new

		aee_client = Savon.client(wsdl: aee_url)
		breakdownSummary = aee_client.call(:get_breakdowns_summary)
		hashtable = breakdownSummary.body

		hashtable.each do |key, value|
			cantidad_de_pueblos = value[:return].length
			for cada_pueblo in 1..cantidad_de_pueblos
				cada_pueblo -= 1
				pueblos.push value[:return][cada_pueblo][:r1_town_or_city]
			end
		end

		pueblos.each do |value|
			breakdownstuff = aee_client.call(:get_breakdowns_by_town_or_city, message: { "townOrCity" => value })
			data = breakdownstuff.body
			if data[:get_breakdowns_by_town_or_city_response][:return].kind_of?(Array)
				cantidad_averias_pueblo = data[:get_breakdowns_by_town_or_city_response][:return].length
				hash_averia = Array.new
				for averias in 1..cantidad_averias_pueblo
					averias -= 1
					hash_averias = Hash.new
					hash_averias["Area:"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r2_area]
					hash_averias["Status:"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r3_status]
					hash_averias["Last Update:"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r4_last_update]
					hash_averia[averias] = hash_averias 
				end
				hash_pueblo["#{data[:get_breakdowns_by_town_or_city_response][:return][averias][:r1_town_or_city]}"] = hash_averia
			else
				hash_pueblo["#{data[:get_breakdowns_by_town_or_city_response][:return][:r1_town_or_city]}"] = data[:get_breakdowns_by_town_or_city_response][:return][:r2_area]
			end
		end
		return hash_pueblo.to_json
	end
end