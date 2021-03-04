using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ERXApi.Repository
{
    public class AdditionalQuestionRepository : IAdditionalQuestionRepository

    {
        private readonly ERXDBContext db;
        public AdditionalQuestionRepository(ERXDBContext _db)
        {
            db = _db;

        }
        public async Task<int> AddAdditionalQuestion(AdditionalQuestion model)
        {
            if (db != null)
            {
                await db.AdditionalQuestions.AddAsync(model);
                await db.SaveChangesAsync();
                return model.QuestionId;
            }

            return 0;
        }

        public async Task<int> DeleteAdditionalQuestion(int? questionId)
        {
            int result = 0;

            if (db != null)
            {
                //Find the Question for specific Question id
                var qData = await db.AdditionalQuestions.FirstOrDefaultAsync(x => x.QuestionId == questionId);

                if (qData != null)
                {
                    //Delete that Question
                    db.AdditionalQuestions.Remove(qData);

                    //Commit the transaction
                    result = await db.SaveChangesAsync();
                }
                return result;
            }

            return result;
        }

        public async Task<List<AdditionalQuestionMappingVw>> GetAdditionalQuestions(int additionalQuesId, int participantId)
        {
            if (db != null)
            {
                return await (from q in db.AdditionalQuestionMappingVws 
                              where q.AdditionalQuestionId == additionalQuesId & q.ParticipantId == participantId select q).ToListAsync();
            }

            return null;
        }
        public async Task<AdditionalQuestionMappingVw> GetAdditionalQuestion(int? qId)
        {
            if (db != null)
            {
                return await (from q in db.AdditionalQuestionMappingVws where q.QuestionId == qId select q).FirstOrDefaultAsync();
            }
            return null;
        }

        public async Task UpdateAdditionalQuestion(AdditionalQuestion model)
        {
            if (db != null)
            {
                //Delete that Question
                db.AdditionalQuestions.Update(model);

                //Commit the transaction
                await db.SaveChangesAsync();
            }
        }

      
    }
}
