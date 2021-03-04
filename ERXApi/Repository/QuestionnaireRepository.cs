using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ERXApi.Repository
{
    public class QuestionnaireRepository : IQuestionnaireRepository
    {
        private readonly ERXDBContext db;
        private IConfiguration Configuration { get; }
        public QuestionnaireRepository(ERXDBContext _db, IConfiguration _configuration)
        {
            db = _db;
            Configuration = _configuration;
        }
        public async Task<List<Country>> GetCountries()
        {
            if (db != null)
            {
                return await db.Countries.ToListAsync();
            }

            return null;
        }
        public async Task<List<Occupation>> GetOccupations()
        {
            if (db != null)
            {
                return await db.Occupations.ToListAsync();
            }

            return null;
        }
        public async Task<List<QuestionnaireVw>> GetQuestionnaires()
        {
            if (db != null)
            {
                return await db.QuestionnaireVws.ToListAsync();
            }

            return null;
        }
        
        public async Task<QuestionnaireVw> GetQuestionnaire(int? participantId)
        {
            if (db != null)
            {
                return await (from q in db.QuestionnaireVws
                              where q.ParticipantId == participantId
                              select new QuestionnaireVw
                              {
                                  ParticipantId = q.ParticipantId,
                                  Title = q.Title,
                                  FirstName = q.FirstName,
                                  LastName = q.LastName,
                                  DateOfBirth = q.DateOfBirth,
                                  CountryId = q.CountryId,
                                  CountryName = q.CountryName,
                                  HouseAddress = q.HouseAddress,
                                  WorkAddress = q.WorkAddress,
                                  OccupationId = q.OccupationId,
                                  OccupationName = q.OccupationName,
                                  JobTitle = q.JobTitle,
                                  BusinessType = q.BusinessType
                              }).FirstOrDefaultAsync();
            }

            return null;
        }

        public async Task<int> AddQuestionnaire(Questionnaire model)
        {
            if (db != null)
            {
                if (model.CountryId != null) {
                    //Not allowed countries : Cambodia, Myanmar, Pakistan
                    var splitContry = Configuration.GetSection("AppSettings").GetSection("NotAllowedCountries").Value.Split(",");
                    foreach (string country in splitContry)
                    {
                        if (model.CountryId.ToString().Contains(country))
                        {
                            return 0;
                        }
                    }
                }
                var lastValue = await db.AdditionalQuestionMappings.OrderByDescending(o => o.AdditionalQuestionId).FirstOrDefaultAsync();
    
                model.AdditionalQuestionId = lastValue == null ? 1 : lastValue.AdditionalQuestionId + 1;

                await db.Questionnaires.AddAsync(model);
                await db.SaveChangesAsync();

                var additionalQuestion = new AdditionalQuestionMapping()
                {
                    AdditionalQuestionId = model.AdditionalQuestionId,
                    ParticipantId = model.ParticipantId
                };
                await db.AdditionalQuestionMappings.AddAsync(additionalQuestion);
                await db.SaveChangesAsync();
                return model.ParticipantId;
            }

            return 0;
        }

        public async Task<int> DeleteQuestionnaire(int? participantId)
        {
            int result = 0;

            if (db != null)
            {
                //Find the Questionnaires for specific Questionnaires id
                var qData = await db.Questionnaires.FirstOrDefaultAsync(x => x.ParticipantId == participantId);

                if (qData != null)
                {
                    //Delete that Questionnaires
                    db.Questionnaires.Remove(qData);

                    //Commit the transaction
                    result = await db.SaveChangesAsync();
                }
                return result;
            }

            return result;
        }

        public async Task UpdateQuestionnaire(Questionnaire model)
        {
            if (db != null)
            {
                //Delete that Questionnaire
                db.Questionnaires.Update(model);

                //Commit the transaction
                await db.SaveChangesAsync();
            }
        }
    }
}
