using System;
using System.Collections.Generic;

#nullable disable

namespace ERXApi.Models
{
    public partial class AdditionalQuestionMappingVw
    {
        public int QuestionId { get; set; }
        public int AdditionalQuestionId { get; set; }
        public int ParticipantId { get; set; }
        public string QuestionType { get; set; }
        public string QuestionTopic { get; set; }
        public string Answer { get; set; }
    }
}
