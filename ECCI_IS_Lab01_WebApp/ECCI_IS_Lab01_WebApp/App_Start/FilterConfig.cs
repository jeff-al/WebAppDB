using System.Web;
using System.Web.Mvc;

namespace ECCI_IS_Lab01_WebApp
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
