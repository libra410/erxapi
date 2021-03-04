using ERXApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ERXApi.Interfaces.Repository
{
    public interface IQuestionnaireRepository
    {
        Task<List<Country>> GetCountries();
        Task<List<Occupation>> GetOccupations();
        Task<List<QuestionnaireVw>> GetQuestionnaires();

        Task<QuestionnaireVw> GetQuestionnaire(int? qId);

        Task<int> AddQuestionnaire(Questionnaire model);

        Task<int> DeleteQuestionnaire(int? qId);
        
        Task UpdateQuestionnaire(Questionnaire model);
    }
}
