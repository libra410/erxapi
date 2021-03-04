using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace ERXApi.Models
{
    public partial class ERXDBContext : DbContext
    {
        public ERXDBContext()
        {
        }

        public ERXDBContext(DbContextOptions<ERXDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AdditionalQuestion> AdditionalQuestions { get; set; }
        public virtual DbSet<AdditionalQuestionMapping> AdditionalQuestionMappings { get; set; }
        public virtual DbSet<AdditionalQuestionMappingVw> AdditionalQuestionMappingVws { get; set; }
        public virtual DbSet<Country> Countries { get; set; }
        public virtual DbSet<Occupation> Occupations { get; set; }
        public virtual DbSet<Questionnaire> Questionnaires { get; set; }
        public virtual DbSet<QuestionnaireVw> QuestionnaireVws { get; set; }

//        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//        {
//            if (!optionsBuilder.IsConfigured)
//            {
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
//                optionsBuilder.UseSqlServer("Server=(local);Database=ERXDB;UID=sa;PWD=P@ssw0rd;");
//            }
//        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<AdditionalQuestion>(entity =>
            {
                entity.HasKey(e => new { e.QuestionId, e.AdditionalQuestionId });

                entity.ToTable("AdditionalQuestion");

                entity.Property(e => e.QuestionId).ValueGeneratedOnAdd();

                entity.Property(e => e.Answer).HasMaxLength(1000);

                entity.Property(e => e.QuestionTopic).HasMaxLength(1000);

                entity.Property(e => e.QuestionType).HasMaxLength(255);
            });

            modelBuilder.Entity<AdditionalQuestionMapping>(entity =>
            {
                entity.HasKey(e => new { e.AdditionalQuestionId, e.ParticipantId });

                entity.ToTable("AdditionalQuestionMapping");
            });

            modelBuilder.Entity<AdditionalQuestionMappingVw>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("AdditionalQuestionMapping_vw");

                entity.Property(e => e.Answer).HasMaxLength(1000);

                entity.Property(e => e.QuestionTopic).HasMaxLength(1000);

                entity.Property(e => e.QuestionType).HasMaxLength(255);
            });

            modelBuilder.Entity<Country>(entity =>
            {
                entity.ToTable("Country");

                entity.Property(e => e.CountryId).ValueGeneratedNever();

                entity.Property(e => e.CapitalName).HasMaxLength(255);

                entity.Property(e => e.Continent).HasMaxLength(255);

                entity.Property(e => e.CountryName).HasMaxLength(255);
            });

            modelBuilder.Entity<Occupation>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("Occupation");

                entity.Property(e => e.OccupationName).HasMaxLength(255);
            });

            modelBuilder.Entity<Questionnaire>(entity =>
            {
                entity.HasKey(e => e.ParticipantId);

                entity.ToTable("Questionnaire");

                entity.Property(e => e.BusinessType).HasMaxLength(50);

                entity.Property(e => e.DateOfBirth).HasColumnType("date");

                entity.Property(e => e.FirstName).HasMaxLength(50);

                entity.Property(e => e.HouseAddress).HasMaxLength(1000);

                entity.Property(e => e.JobTitle).HasMaxLength(50);

                entity.Property(e => e.LastName).HasMaxLength(50);

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.WorkAddress).HasMaxLength(1000);
            });

            modelBuilder.Entity<QuestionnaireVw>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("Questionnaire_vw");

                entity.Property(e => e.BusinessType).HasMaxLength(50);

                entity.Property(e => e.CountryName).HasMaxLength(255);

                entity.Property(e => e.DateOfBirth).HasColumnType("date");

                entity.Property(e => e.FirstName).HasMaxLength(50);

                entity.Property(e => e.HouseAddress).HasMaxLength(1000);

                entity.Property(e => e.JobTitle).HasMaxLength(50);

                entity.Property(e => e.LastName).HasMaxLength(50);

                entity.Property(e => e.OccupationName).HasMaxLength(255);

                entity.Property(e => e.Title).HasMaxLength(50);

                entity.Property(e => e.WorkAddress).HasMaxLength(1000);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
