module HExcelFinance
	using HTTP
	using JSON
	using Serialization

	export YahooQuote, ParseInternet, YahooOptionChain, DeserializeFile, SerializeFile

	ParseInternet(url) = JSON.parse(String(
		HTTP.get(url, 
			readtimeout = 5,
			retry = false,
			redirect = false).body))

	function YahooQuote(sym)
		res = ParseInternet("https://query1.finance.yahoo.com/v7/finance/quote?symbols=$sym")
		if haskey(res, "quoteResponse")
			return res["quoteResponse"]["result"][1]
		end
		res
	end

	function YahooOptionChain(sym)
		res = ParseInternet("https://query1.finance.yahoo.com/v7/finance/options/$sym")
		if haskey(res, "optionChain")
			return res["optionChain"]["result"][1]["options"][1]
		end
		res
	end

	DeserializeFile(dir, fileName) = deserialize("$(replace(dir, "\\" => "/"))/$(fileName).bin")
	
	function SerializeFile(dir, fileName, obj)
		dir = replace(dir, "\\" => "/")
		mkpath(dir)
		serialize("$(dir)/$(fileName).bin", obj)
	end
	
	precompile(YahooQuote, (String,))
	precompile(YahooOptionChain, (String,))
	precompile(DeserializeFile, (String, String))
	precompile(SerializeFile, (String, String, Any))

end



