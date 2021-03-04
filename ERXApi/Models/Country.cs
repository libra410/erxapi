using System;
using System.Collections.Generic;

#nullable disable

namespace ERXApi.Models
{
    public partial class Country
    {
        public int CountryId { get; set; }
        public string CountryName { get; set; }
        public string CapitalName { get; set; }
        public string Continent { get; set; }
    }
}
