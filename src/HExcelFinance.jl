module HExcelFinance
	using HTTP
	using JSON
	using Serialization

	export YahooQuote, ParseInternet, YahooOptionChain, DeserializeFile, SerializeFile

	ParseInternet(url) = JSON.parse(String(HTTP.get(url).body))

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

	DeserializeFile(dir, fileName) = deserialize(joinpath(replace(dir, "\\" => "/"), fileName * ".bin"))
	
	function SerializeFile(dir, fileName, obj)
		dir = replace(dir, "\\" => "/")
		mkpath(dir)
		serialize(joinpath(dir, fileName * ".bin"), obj)
	end
	
	precompile(YahooQuote, (string,))
	precompile(YahooOptionChain, (string,))
	precompile(DeserializeFile, (string, string))
	precompile(SerializeFile, (string, string, Any))

end



