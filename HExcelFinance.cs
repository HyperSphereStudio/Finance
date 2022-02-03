using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using JuliaInterface;
using ExcelDna.Integration;
using HyperSphere;

public class HExcelFinance
{
    private static JLFun parseInternet, yahooQuote;
    private static JLType yahooOptionChain;


    [ExcelFunction(Name = "Finance.ParseInternet", IsThreadSafe = true, IsMacroType = true)] public static object ParseInternet(string url) => Nt.Box(parseInternet.Invoke(url));
    [ExcelFunction(Name = "Finance.YahooQuote", IsThreadSafe = true, IsMacroType = true)] public static object YahooQuote(string symbol) => Nt.Box(yahooQuote.Invoke(symbol));
    [ExcelFunction(Name = "Finance.YahooOptionChain", IsThreadSafe = true, IsMacroType = true)] public static object YahooOptionChain(string symbol) => Nt.Box(yahooOptionChain.Create(symbol));

    public static Type[] Main() {
        parseInternet = Julia.Eval("ParseInternet");
        yahooQuote = Julia.Eval("YahooQuote");
        yahooOptionChain = Julia.Eval("YahooOptionChain");

        return new Type[0];
    }


}
