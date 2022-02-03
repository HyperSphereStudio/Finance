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
    private static JLFun parseInternet, yahooQuote, yahooOptionChain, serializeFile, deserializeFile;


    [ExcelFunction(Name = "Finance.ParseInternet", IsThreadSafe = true, IsMacroType = true)] public static object ParseInternet(string url) => Nt.Box(parseInternet.Invoke(url));
    [ExcelFunction(Name = "Finance.YahooQuote", IsThreadSafe = true, IsMacroType = true)] public static object YahooQuote(string symbol) => Nt.Box(yahooQuote.Invoke(symbol));
    [ExcelFunction(Name = "Finance.YahooOptionChain", IsThreadSafe = true, IsMacroType = true)] public static object YahooOptionChain(string symbol) => Nt.Box(yahooOptionChain.Invoke(symbol));
    
    [ExcelFunction(Name = "Finance.SerializeFile", IsThreadSafe = true, IsMacroType = true)] public static object SerializeFile(string dir, string fileName, object o)
    {
        serializeFile.Invoke(dir, fileName, Jl.Xlunbox(o));
        return "Serialized File!";
    }

    [ExcelFunction(Name = "Finance.DeserializeFile", IsThreadSafe = true, IsMacroType = true)] public static object DeserializeFile(string dir, string fileName) => Nt.Box(deserializeFile.Invoke(dir, fileName));


    public static Type[] Main() {
        parseInternet = Julia.Eval("ParseInternet");
        yahooQuote = Julia.Eval("YahooQuote");
        yahooOptionChain = Julia.Eval("YahooOptionChain");
        serializeFile = Julia.Eval("SerializeFile");
        deserializeFile = Julia.Eval("DeserializeFile");

        return new Type[0];
    }


}
