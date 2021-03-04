using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ERXApi.Repository
{
    public class AdditionalQuestionMappingRepository : IAdditionalQuestionMappingRepository
    {
        private readonly ERXDBContext db;
        public AdditionalQuestionMappingRepository(ERXDBContext _db)
        {
            db = _db;
        }

        public async Task<int> DeleteAdditionalQuestion(int? aqId)
        {
            int result = 0;

            if (db != null)
            {
                //Find the Question for specific Question id
                var qData = await db.AdditionalQuestionMappings.FirstOrDefaultAsync(x => x.AdditionalQuestionId == aqId);

                if (qData != null)
                {
                    //Delete that Question
                    db.AdditionalQuestionMappings.Remove(qData);

                    //Commit the transaction
                    result = await db.SaveChangesAsync();
                }
                return result;
            }

            return result;
        }


    }
}
