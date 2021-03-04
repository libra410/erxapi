using ERXApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ERXApi.Interfaces.Repository
{
    public interface IAdditionalQuestionRepository
    {
        Task<List<AdditionalQuestionMappingVw>> GetAdditionalQuestions(int additionalQuesId,int participantId);

        Task<AdditionalQuestionMappingVw> GetAdditionalQuestion(int? qId);

        Task<int> AddAdditionalQuestion(AdditionalQuestion model);

        Task<int> DeleteAdditionalQuestion(int? qId);

        Task UpdateAdditionalQuestion(AdditionalQuestion model);
    }
}
