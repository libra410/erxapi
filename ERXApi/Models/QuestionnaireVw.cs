using System;
using System.Collections.Generic;

#nullable disable

namespace ERXApi.Models
{
    public partial class QuestionnaireVw
    {
        public int ParticipantId { get; set; }
        public string Title { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public int? CountryId { get; set; }
        public string CountryName { get; set; }
        public string HouseAddress { get; set; }
        public string WorkAddress { get; set; }
        public int? OccupationId { get; set; }
        public string OccupationName { get; set; }
        public string JobTitle { get; set; }
        public string BusinessType { get; set; }
        public int? AdditionalQuestionId { get; set; }
    }
}
