require 'savon'
require 'json'

class AEE_API
	def get_lista
		aee_client = Savon.client(wsdl: 'http://wss.prepa.com/services/BreakdownReport?wsdl')
		breakdownSummary = aee_client.call(:get_breakdowns_summary)
	 	hashtable = breakdownSummary.body
		array_info = Array.new

		hashtable.each do |key, value|
			for cada_pueblo in 0...value[:return].length
				info = Hash.new
				info["Pueblo"] = value[:return][cada_pueblo][:r1_town_or_city]
				info["Cantidad de averias"] = value[:return][cada_pueblo][:r2_total_breakdowns]
				array_info.push info
			end
		end
		return array_info.to_json
	end

	def pueblo_especifico(pueblito)
		aee_client = Savon.client(wsdl: 'http://wss.prepa.com/services/BreakdownReport?wsdl')
		breakdownstuff = aee_client.call(:get_breakdowns_by_town_or_city, message: { "townOrCity" => pueblito.upcase })
		
		hash_table = breakdownstuff.body
		array_final = Array.new

		hash_table.each do |key, value|
			# Checks if its an array of hashes or a hash
			if value[:return].kind_of?(Array)
				hash_array_averias = Array.new
				hash_pueblo = Hash.new
				for averias in 0...value[:return].length
					hash_averias = Hash.new
					hash_averias["Area"] = value[:return][averias][:r2_area]
					hash_averias["Status"] = value[:return][averias][:r3_status]
					hash_averias["Last Update"] = value[:return][averias][:r4_last_update]
					hash_array_averias[averias] = hash_averias
				end
				hash_pueblo["Pueblo"] = value[:return][averias][:r1_town_or_city]
				hash_pueblo["Averias"] = hash_array_averias
				array_final.push hash_pueblo
			else
				hash_averia = Hash.new
				hash_pueblo = Hash.new
				array_averia = Array.new
				hash_averia["Area"] = value[:return][:r2_area]
				hash_averia["Status"] = value[:return][:r3_status]
				hash_averia["Last Update"] = value[:return][:r4_last_update]
				array_averia.push hash_averia
				hash_pueblo["Pueblo"] = value[:return][:r1_town_or_city]
				hash_pueblo["Averias"] = array_averia
				array_final.push hash_pueblo
			end
		end
		return array_final.to_json
	end

	def all_averias
		aee_url = 'http://wss.prepa.com/services/BreakdownReport?wsdl'
		pueblos = Array.new
		array_final = Array.new

		aee_client = Savon.client(wsdl: aee_url)
		breakdownSummary = aee_client.call(:get_breakdowns_summary)
		hashtable = breakdownSummary.body

		hashtable.each do |key, value|
			for cada_pueblo in 0...value[:return].length
				pueblos.push value[:return][cada_pueblo][:r1_town_or_city]
			end
		end

		pueblos.each do |value|
			breakdownstuff = aee_client.call(:get_breakdowns_by_town_or_city, message: { "townOrCity" => value })
			data = breakdownstuff.body
			if data[:get_breakdowns_by_town_or_city_response][:return].kind_of?(Array)
				array_averias = Array.new
				hash_pueblo_multi = Hash.new
				for averias in 0...data[:get_breakdowns_by_town_or_city_response][:return].length
					hash_averias = Hash.new
					hash_averias["Area"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r2_area]
					hash_averias["Status"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r3_status]
					hash_averias["Last Update"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r4_last_update]
					array_averias[averias] = hash_averias 
				end
				hash_pueblo_multi["Pueblo"] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r1_town_or_city] 
				hash_pueblo_multi["Averias"] = array_averias
				array_final.push hash_pueblo_multi
			else
				hash_averia = Hash.new
				array_averia = Array.new
				hash_pueblo = Hash.new
				hash_averia["Area"] = data[:get_breakdowns_by_town_or_city_response][:return][:r2_area]
				hash_averia["Status"] = data[:get_breakdowns_by_town_or_city_response][:return][:r3_status]
				hash_averia["Last Update"] = data[:get_breakdowns_by_town_or_city_response][:return][:r3_status]
				array_averia.push hash_averia
				hash_pueblo["Pueblo"] = data[:get_breakdowns_by_town_or_city_response][:return][:r1_town_or_city]
				hash_pueblo["Averias"] = array_averia
				array_final.push hash_pueblo
			end
		end
		return array_final.to_json
	end
end