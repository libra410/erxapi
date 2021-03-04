using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using ERXApi.Repository;
using Microsoft.EntityFrameworkCore;
using NUnit.Framework;
using NUnitTestERXApi;


namespace NUnitTestERXApi.Repository
{
    [TestFixture(Category ="QuestionareRepository")]
    public class QuestionnaireRepositoryUnitTest
    {
        private IQuestionnaireRepository questionnaireRepository;
        //private readonly ERXDBContext db;
        int result = 0;

        private DbContextOptions<ERXDBContext> db = new DbContextOptionsBuilder<ERXDBContext>()
        .UseInMemoryDatabase(databaseName: "ERXDB")
        .Options;
        //private ReservationsController controller;

        [OneTimeSetUp]
        public void Setup() {


            questionnaireRepository = new QuestionnaireRepository(new ERXDBContext(db), TestHelper.InitConfiguration());

            //controller = new ReservationsController(new PrimeDbContext(dbContextOptions));
        }

        [TestCase]
        public async Task When_GetCountries() {

            //Arrange
            using var context = new ERXDBContext(db);

            //Act
            var result = await questionnaireRepository.GetCountries();

            //Assert
            Assert.IsNotNull(result);

        }
    }
}
