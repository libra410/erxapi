using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using CsvHelper;
using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using Microsoft.AspNetCore.Mvc;
using ERXApi.Utility;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ERXApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionnairesController : ControllerBase
    {
        readonly IQuestionnaireRepository questionnaireRepository;
        public QuestionnairesController(IQuestionnaireRepository _questionnaireRepository)
        {
            questionnaireRepository = _questionnaireRepository;
        }

        // GET: api/<QuestionnairesController>
        /// <summary>
        /// Get all country
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetCountries")]
        public async Task<IActionResult> GetCountries()
        {
            try
            {
                var results = await questionnaireRepository.GetCountries();
                if (results == null)
                {
                    return NotFound(Message.MessageDataNotFound);
                }

                return Ok(results);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Get all occupations
        /// </summary>
        /// <returns></returns>
        // GET: api/<QuestionnairesController>
        [HttpGet]
        [Route("GetOccupations")]
        public async Task<IActionResult> GetOccupations()
        {
            try
            {
                var results = await questionnaireRepository.GetOccupations();
                if (results == null)
                {
                    return NotFound(Message.MessageDataNotFound);
                }

                return Ok(results);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Download answer questionnaires format csv file 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("DownloadAnswerQuestionnaires")]
        public async Task<IActionResult> DownloadAnswerQuestionnaires()
        {
            try
            {
                var results = await questionnaireRepository.GetQuestionnaires();
                if (results == null)
                {
                    return NotFound();
                }
                var stream = new MemoryStream();
                using (var writer = new StreamWriter(stream, leaveOpen: true))
                using (var csv = new CsvWriter(writer, CultureInfo.InvariantCulture))
                {
                    csv.WriteHeader<QuestionnaireVw>();
                    csv.NextRecord();
                    foreach (var record in results)
                    {
                        csv.WriteRecord(record);
                        csv.NextRecord();
                    }
                }
                stream.Position = 0; //reset stream
                return File(stream, "application/octet-stream", "AnswerQuestionnaires.csv");


            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        ///  Download answer questionnaires format csv file by participant id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("DownloadAnswerQuestionnaire/{id}")]
        public async Task<IActionResult> DownloadAnswerQuestionnaire(int? id)
        {
            try
            {
                var results = await questionnaireRepository.GetQuestionnaire(id);
                if (results == null)
                {
                    return NotFound();
                }
                var stream = new MemoryStream();
                using (var writer = new StreamWriter(stream, leaveOpen: true))
                using (var csv = new CsvWriter(writer, CultureInfo.InvariantCulture))
                {
                    csv.WriteHeader<QuestionnaireVw>();
                    csv.NextRecord();
                    csv.WriteRecord(results);
                    csv.NextRecord();
                }
                stream.Position = 0; //reset stream
                return File(stream, "application/octet-stream", "AnswerQuestionnaire.csv");

                
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Get all questionares
        /// </summary>
        /// <returns></returns>
        // GET: api/<QuestionnairesController>
        [HttpGet]
        public async Task<IActionResult> GetQuestionnaires()
        {
            try
            {
                var results = await questionnaireRepository.GetQuestionnaires();
                if (results == null)
                {
                    return NotFound(Message.MessageDataNotFound);
                }

                return Ok(results);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Get questionnaire by participant id 
        /// </summary>
        /// <param name="id">Participant id</param>
        /// <returns></returns>
        // GET api/<QuestionnairesController>/5
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int? id)
        {
            if (id == null)
            {
                return BadRequest();
            }
            try
            {
                var results = await questionnaireRepository.GetQuestionnaire(id);

                if (results == null)
                {
                    return NotFound(Message.MessageDataNotFound);
                }

                return Ok(results);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Save questionare 
        /// </summary>
        /// <param name="model">Questionnaire model</param>
        /// <returns></returns>
        // POST api/<QuestionnairesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Questionnaire model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var qId = await questionnaireRepository.AddQuestionnaire(model);
                    if (qId > 0)
                    {
                        return Ok(qId);
                    }
                    else
                    {
                        return NotFound(Message.MessageSelectedNotAllowedCountry);
                    }
                }
                catch (Exception ex)
                {

                    return BadRequest(ex.Message);
                }

            }

            return BadRequest();
        }

        /// <summary>
        ///  Update questionare 
        /// </summary>
        /// <param name="model">Questionnaire model</param>
        /// <returns></returns>
        // PUT api/<QuestionnairesController>
        [HttpPut]
        public async Task<IActionResult> Put([FromBody] Questionnaire model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                   // model.Qid = id;
                    await questionnaireRepository.UpdateQuestionnaire(model);
                    return Ok(Message.UpdateSuccess);
                }
                catch (Exception ex)
                {
                    if (ex.GetType().FullName == "Microsoft.EntityFrameworkCore.DbUpdateConcurrencyException")
                    {
                        return NotFound();
                    }

                    return BadRequest();
                }
            }

            return BadRequest();
        }

        /// <summary>
        /// Delete questionare 
        /// </summary>
        /// <param name="id">Participant id</param>
        /// <returns></returns>
        // DELETE api/<QuestionnairesController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int? id)
        {
            int result = 0;

            if (id == null)
            {
                return BadRequest();
            }
            try
            {
                result = await questionnaireRepository.DeleteQuestionnaire(id);
                if (result == 0)
                {
                    return NotFound();
                }
                return Ok(Message.DeleteSuccess);
            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }
        }
    }
}
