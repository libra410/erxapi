using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using ERXApi.Utility;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ERXApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdditionalQuestionsController : ControllerBase
    {

        readonly  IAdditionalQuestionRepository additionalQuestionRepository;
        public AdditionalQuestionsController(IAdditionalQuestionRepository _additionalQuestionRepository)
        {
            additionalQuestionRepository = _additionalQuestionRepository;
        }

        // GET: api/<AdditionalQuestionsController>
        [HttpGet("{additionalQuesId}/{participantId}")]
        public async Task<IActionResult> Get(int additionalQuesId,int participantId)
        {
            try
            {
                var results = await additionalQuestionRepository.GetAdditionalQuestions(additionalQuesId, participantId);
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


        // POST api/<AdditionalQuestionsController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] AdditionalQuestion model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var qId = await additionalQuestionRepository.AddAdditionalQuestion(model);
                    if (qId > 0)
                    {
                        return Ok(qId);
                    }
                    else
                    {
                        return NotFound(Message.MessageSomethingWentWrong);
                    }
                }
                catch (Exception ex)
                {

                    return BadRequest(ex.Message);
                }

            }

            return BadRequest();
        }

        // PUT api/<AdditionalQuestionsController>/5
        [HttpPut]
        public async Task<IActionResult> Put([FromBody] AdditionalQuestion model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // model.Qid = id;
                    await additionalQuestionRepository.UpdateAdditionalQuestion(model);
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

        // DELETE api/<AdditionalQuestionsController>/5
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
                result = await additionalQuestionRepository.DeleteAdditionalQuestion(id);
                if (result == 0)
                {
                    return NotFound(Message.MessageDataNotFound);
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
