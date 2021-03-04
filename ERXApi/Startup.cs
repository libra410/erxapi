using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using ERXApi.Interfaces.Repository;
using ERXApi.Models;
using ERXApi.Repository;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;

namespace ERXAPI
{
    public class Startup
    {
        private const string _erxPolicy = "ERXPolicy";
        public Startup(IConfiguration _configuration)
        {
            configuration = _configuration;
        }

        public IConfiguration configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddCors(option => option.AddPolicy(_erxPolicy, builder => {
                builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();

            }));

            services.AddControllers();
            services.AddDbContext<ERXDBContext>(item => item.UseSqlServer(configuration.GetConnectionString("ERXDBConnection")));
            services.AddScoped<IQuestionnaireRepository, QuestionnaireRepository>();
            services.AddScoped<IAdditionalQuestionRepository, AdditionalQuestionRepository>();

            //services.AddSwaggerGen();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("V1", new OpenApiInfo { Title = "ERX Api", Version = "V1" });
                c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First()); //This line
                //var xmlPath = System.AppDomain.CurrentDomain.BaseDirectory + "ERXApi.XML";
                //c.IncludeXmlComments(xmlPath);
                //c.SwaggerDoc("V1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "ERX Api", Version = "V1" });
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("v1/swagger.json", "ERX Api V1");
                //c.SwaggerEndpoint("/swagger/v1/swagger.json", "ERX Api V1");
            });
            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();
            app.UseCors(_erxPolicy);
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
