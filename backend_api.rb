require 'savon'
require 'json'

class AEE_API
	def list_of_breakdowns
		aee_towns_client = Savon.client(wsdl: 'http://wss.prepa.com/services/BreakdownReport?wsdl')
		aee_call = aee_towns_client.call(:get_breakdowns_summary)

		towns_summary = Array.new

		aee_call.body.each do |k, v|
			acs = v[:return]
			for i in 0...acs.length
				town_summary = {"Pueblo" => acs[i][:r1_town_or_city],
												"Cantidad de averias" => acs[i][:r2_total_breakdowns]}
				towns_summary.push town_summary
			end
		end
		return towns_summary
	end

	def get_list
		return list_of_breakdowns.to_json
	end

	def specific_town(town, decs)
		aee_towns_client = Savon.client(wsdl: 'http://wss.prepa.com/services/BreakdownReport?wsdl')
		aee_call = aee_towns_client.call(:get_breakdowns_by_town_or_city, message: {"townOrCity" => town.upcase})

		aee_call.body.each do |k, v|
			acs = v[:return]
			town = Hash.new
			if acs.kind_of?(Array)
				breakdowns = Array.new
				for brkdwn in 0...acs.length
					breakdowns.push ["Area" => acs[brkdwn][:r2_area],
													"Status" => acs[brkdwn][:r3_status],
													"Last Update" => acs[brkdwn][:r4_last_update]]
				end
				town["Pueblo"] = acs[brkdwn][:r1_town_or_city]
				town["Averias"] = breakdowns
			 	decs ? (return town) : (return [town])
			else
				breakdown = ["Area" => acs[:r2_area],
										"Status" => acs[:r3_status],
										"Last Update" => acs[:r4_last_update]]
				town["Pueblo"] = acs[:r1_town_or_city]
				town["Averias"] = breakdown
				decs ? (return town) : (return [town])
			end
		end
	end

	def get_specific_town(town)
		return specific_town(town, false).to_json
	end

	def get_all_breakdowns
		list = list_of_breakdowns
		all_breakdowns = Array.new
		for i in 0...list.length
			all_breakdowns.push specific_town(list[i][0]["Pueblo"], true)
		end
		return all_breakdowns.to_json
	end
end
