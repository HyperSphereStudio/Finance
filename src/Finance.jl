module Finance
	using HTTP
	using JSON

	export YahooQuote, ParseInternet, YahooOptionChain

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
	
	precompile(YahooQuote, (string,))
	precompile(YahooOptionChain, (string,))
	
end



