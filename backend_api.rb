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

		hash_table.each do |key, value|
			cantidad_averias_pueblo = value[:return].length
			# Checks if its an array of hashes or a hash
			if value[:return].kind_of?(Array)
				hash_hash = Hash.new
				for averias in 1..cantidad_averias_pueblo
					averias -= 1
					hash_hash["Area: "] = value[:return][averias][:r2_area]
					hash_hash["Status: "] = value[:return][averias][:r3_status]
					hash_hash["Last Update: "] = value[:return][averias][:r4_last_update]
					hash_pueblo["#{value[:return][averias][:r1_town_or_city]}"] = hash_hash
				end
			else
				hash_hash["Area: "] = value[:return][:r2_area]
				hash_hash["Status: "] = value[:return][:r3_status]
				hash_hash["Last Update: "] = value[:return][:r4_last_update]
				hash_pueblo["#{value[:return][:r1_town_or_city]}"] = hash_hash
			end
		end
		return hash_pueblo.to_json
	end

	def all_averias
		aee_url = 'http://wss.prepa.com/services/BreakdownReport?wsdl'
		pueblos = Array.new
		hash_pueblo = Hash.new

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
					hash_averia[averias] = data[:get_breakdowns_by_town_or_city_response][:return][averias][:r2_area] 
				end
				hash_pueblo["#{data[:get_breakdowns_by_town_or_city_response][:return][averias][:r1_town_or_city]}"] = hash_averia
			else
				hash_pueblo["#{data[:get_breakdowns_by_town_or_city_response][:return][:r1_town_or_city]}"] = data[:get_breakdowns_by_town_or_city_response][:return][:r2_area]
			end
		end
		return hash_pueblo.to_json
	end
end