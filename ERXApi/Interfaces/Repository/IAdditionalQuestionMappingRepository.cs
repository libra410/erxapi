using ERXApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ERXApi.Interfaces.Repository
{
    public interface IAdditionalQuestionMappingRepository
    {
        Task<int> DeleteAdditionalQuestion(int? aqId);

    }
}
