USE [ERXDB]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 3/5/2021 12:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](255) NULL,
	[CapitalName] [nvarchar](255) NULL,
	[Continent] [nvarchar](255) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Occupation]    Script Date: 3/5/2021 12:32:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Occupation](
	[OccupationId] [int] NULL,
	[OccupationName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questionnaire]    Script Date: 3/5/2021 12:32:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questionnaire](
	[ParticipantId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[DateOfBirth] [date] NULL,
	[CountryId] [int] NULL,
	[HouseAddress] [nvarchar](1000) NULL,
	[WorkAddress] [nvarchar](1000) NULL,
	[OccupationId] [int] NULL,
	[JobTitle] [nvarchar](50) NULL,
	[BusinessType] [nvarchar](50) NULL,
	[AdditionalQuestionId] [int] NOT NULL,
 CONSTRAINT [PK_Questionnaire] PRIMARY KEY CLUSTERED 
(
	[ParticipantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Questionnaire_vw]    Script Date: 3/5/2021 12:32:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Questionnaire_vw]
AS
SELECT        dbo.Questionnaire.ParticipantId, dbo.Questionnaire.Title, dbo.Questionnaire.FirstName, dbo.Questionnaire.LastName, dbo.Questionnaire.DateOfBirth, dbo.Questionnaire.CountryId, dbo.Country.CountryName, 
                         dbo.Questionnaire.HouseAddress, dbo.Questionnaire.WorkAddress, dbo.Questionnaire.OccupationId, dbo.Occupation.OccupationName, dbo.Questionnaire.JobTitle, dbo.Questionnaire.BusinessType, 
                         dbo.Questionnaire.AdditionalQuestionId
FROM            dbo.Occupation RIGHT OUTER JOIN
                         dbo.Questionnaire ON dbo.Occupation.OccupationId = dbo.Questionnaire.OccupationId LEFT OUTER JOIN
                         dbo.Country ON dbo.Questionnaire.CountryId = dbo.Country.CountryId
GO
/****** Object:  Table [dbo].[AdditionalQuestionMapping]    Script Date: 3/5/2021 12:32:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdditionalQuestionMapping](
	[AdditionalQuestionId] [int] NOT NULL,
	[ParticipantId] [int] NOT NULL,
 CONSTRAINT [PK_AdditionalQuestionMapping] PRIMARY KEY CLUSTERED 
(
	[AdditionalQuestionId] ASC,
	[ParticipantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdditionalQuestion]    Script Date: 3/5/2021 12:32:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdditionalQuestion](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[AdditionalQuestionId] [int] NOT NULL,
	[QuestionType] [nvarchar](255) NULL,
	[QuestionTopic] [nvarchar](1000) NULL,
	[Answer] [nvarchar](1000) NULL,
 CONSTRAINT [PK_AdditionalQuestion] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC,
	[AdditionalQuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AdditionalQuestionMapping_vw]    Script Date: 3/5/2021 12:32:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AdditionalQuestionMapping_vw]
AS
SELECT        dbo.AdditionalQuestion.QuestionId, dbo.AdditionalQuestion.AdditionalQuestionId, dbo.AdditionalQuestionMapping.ParticipantId, dbo.AdditionalQuestion.QuestionType, dbo.AdditionalQuestion.QuestionTopic, 
                         dbo.AdditionalQuestion.Answer
FROM            dbo.AdditionalQuestion INNER JOIN
                         dbo.AdditionalQuestionMapping ON dbo.AdditionalQuestion.AdditionalQuestionId = dbo.AdditionalQuestionMapping.AdditionalQuestionId
GO
SET IDENTITY_INSERT [dbo].[AdditionalQuestion] ON 

INSERT [dbo].[AdditionalQuestion] ([QuestionId], [AdditionalQuestionId], [QuestionType], [QuestionTopic], [Answer]) VALUES (1, 1, N'TextBox', N'Why did you purchase this product?', N'I love it')
INSERT [dbo].[AdditionalQuestion] ([QuestionId], [AdditionalQuestionId], [QuestionType], [QuestionTopic], [Answer]) VALUES (2, 1, N'Checkbox', N'Would you recommend to a friend?', N'Yes')
INSERT [dbo].[AdditionalQuestion] ([QuestionId], [AdditionalQuestionId], [QuestionType], [QuestionTopic], [Answer]) VALUES (4, 1, N'TextBox', N'What is your favorite product?', N'Home Theater')
SET IDENTITY_INSERT [dbo].[AdditionalQuestion] OFF
INSERT [dbo].[AdditionalQuestionMapping] ([AdditionalQuestionId], [ParticipantId]) VALUES (1, 1)
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (1, N'Afghanistan ', N'Kabul ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (2, N'Albania ', N'Tirana ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (3, N'Algeria ', N'Algiers ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (4, N'American Samoa (USA)', N'Pago Pago ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (5, N'Andorra ', N'Andorra La Vella ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (6, N'Angola ', N'Luanda ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (7, N'Anguilla (UK)', N'The Valley ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (8, N'Antigua and Barbuda ', N'Saint Johns', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (9, N'Argentina ', N'Buenos Aires ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (10, N'Armenia ', N'Yerevan ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (11, N'Aruba (Netherlands)', N'Oranjestad ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (12, N'Australia ', N'Canberra ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (13, N'Austria ', N'Vienna ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (14, N'Azerbaijan ', N'Baku ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (15, N'Bahamas ', N'Nassau ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (16, N'Bahrain ', N'Manama ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (17, N'Bangladesh ', N'Dhaka ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (18, N'Barbados ', N'Bridgetown ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (19, N'Belarus ', N'Minsk ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (20, N'Belgium ', N'Brussels ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (21, N'Belize ', N'Belmopan ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (22, N'Benin ', N'Porto-Novo', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (23, N'Bermuda (UK)', N'Hamilton ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (24, N'Bhutan ', N'Thimphu ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (25, N'Bolivia ', N'Sucre', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (26, N'Bosnia and Herzegovina ', N'Sarajevo ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (27, N'Botswana ', N'Gaborone ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (28, N'Brazil ', N'Brasília ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (29, N'British Virgin Islands (UK)', N'Road Town ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (30, N'Brunei ', N'Bandar Seri Begawan ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (31, N'Bulgaria ', N'Sofia ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (32, N'Burkina Faso ', N'Ouagadougou ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (33, N'Burundi ', N'Bujumbura ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (34, N'Cambodia ', N'Phnom Penh ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (35, N'Cameroon ', N'Yaoundé ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (36, N'Canada ', N'Ottawa ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (37, N'Cape Verde ', N'Praia ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (38, N'Cayman Islands (UK)', N'George Town ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (39, N'Central African Republic ', N'Bangui ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (40, N'Chad ', N'N''Djamena ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (41, N'Chile ', N'Santiago ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (42, N'China', N'Beijing ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (43, N'Christmas Island (Australia)', N'Flying Fish Cove ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (44, N'Cocos (Keeling) Islands (Australia)', N'West Island, Cocos Islands ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (45, N'Colombia ', N'Bogotá ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (46, N'Comoros ', N'Moroni ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (47, N'Cook Islands (New Zealand)', N'Avarua ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (48, N'Costa Rica ', N'San José ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (49, N'Croatia ', N'Zagreb ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (50, N'Cuba ', N'Havana ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (51, N'Curacao (Netherlands)', N'Willemstad ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (52, N'Cyprus ', N'Nicosia ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (53, N'Czech Republic ', N'Prague ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (54, N'D.R Congo ', N'Kinshasa ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (55, N'Denmark ', N'Copenhagen ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (56, N'Djibouti ', N'Djibouti-city', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (57, N'Dominica ', N'Roseau ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (58, N'Dominican Republic ', N'Santo Domingo ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (59, N'East Timor (Timor-Leste) ', N'Dili ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (60, N'Ecuador ', N'Quito ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (61, N'Egypt ', N'Cairo ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (62, N'El Salvador ', N'San Salvador ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (63, N'Equatorial Guinea ', N'Malabo ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (64, N'Eritrea ', N'Asmara ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (65, N'Estonia ', N'Tallinn ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (66, N'Ethiopia ', N'Addis Ababa ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (67, N'Falkland Islands (UK)', N'Stanley ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (68, N'Faroe Islands (Denmark)', N'Tórshavn ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (69, N'Fiji ', N'Suva ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (70, N'Finland ', N'Helsinki ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (71, N'France ', N'Paris ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (72, N'French Guiana (France)', N'Cayenne ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (73, N'French Polynesia (France)', N'Papeete ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (74, N'Gabon ', N'Libreville ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (75, N'Gambia ', N'Banjul ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (76, N'Georgia ', N'Tbilisi ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (77, N'Germany ', N'Berlin ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (78, N'Ghana ', N'Accra ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (79, N'Gibraltar (UK)', N'Gibraltar ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (80, N'Greece ', N'Athens ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (81, N'Greenland (Denmark)', N'Nuuk ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (82, N'Grenada ', N'St. George''s ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (83, N'Guam (USA)', N'Hagatna ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (84, N'Guatemala ', N'Guatemala City', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (85, N'Guernsey (UK)', N'Saint Peter Port', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (86, N'Guinea ', N'Conakry ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (87, N'Guinea-Bissau ', N'Bissau ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (88, N'Guyana ', N'Georgetown ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (89, N'Haiti ', N'Port-au-prince ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (90, N'Honduras ', N'Tegucigalpa ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (91, N'Hong Kong (China)', N'Hong Kong City', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (92, N'Hungary ', N'Budapest ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (93, N'Iceland ', N'Reykjavík ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (94, N'India ', N'New Delhi ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (95, N'Indonesia ', N'Jakarta ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (96, N'Iran ', N'Tehran ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (97, N'Iraq ', N'Baghdad ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (98, N'Ireland ', N'Dublin ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (99, N'Isle of Man (UK)', N'Douglas ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (100, N'Israel ', N'Jerusalem', N'Asia')
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (101, N'Italy ', N'Rome ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (102, N'Ivory Coast ', N'Yamoussoukro', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (103, N'Jamaica ', N'Kingston ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (104, N'Japan ', N'Tokyo ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (105, N'Jersey (UK)', N'Saint Helier', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (106, N'Jordan ', N'Amman ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (107, N'Kazakhstan ', N'Astana ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (108, N'Kenya ', N'Nairobi ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (109, N'Kiribati ', N'Tarawa ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (110, N'Kosovo', N'Pristina ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (111, N'Kuwait ', N'Kuwait City ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (112, N'Kyrgyzstan ', N'Bishkek ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (113, N'Laos ', N'Vientiane ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (114, N'Latvia ', N'Riga ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (115, N'Lebanon ', N'Beirut ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (116, N'Lesotho ', N'Maseru ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (117, N'Liberia ', N'Monrovia ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (118, N'Libya ', N'Tripoli ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (119, N'Liechtenstein ', N'Vaduz ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (120, N'Lithuania ', N'Vilnius ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (121, N'Luxembourg ', N'Luxembourg ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (122, N'Macedonia ', N'Skopje ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (123, N'Madagascar ', N'Antananarivo ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (124, N'Malawi ', N'Lilongwe ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (125, N'Malaysia', N'Kuala Lumpur ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (126, N'Maldives ', N'Malé ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (127, N'Mali ', N'Bamako ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (128, N'Malta ', N'Valletta ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (129, N'Marshall Islands ', N'Majuro ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (130, N'Mauritania ', N'Nouakchott ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (131, N'Mauritius ', N'Port Louis ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (132, N'Mexico ', N'Mexico City ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (133, N'Micronesia ', N'Palikir ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (134, N'Moldova ', N'Chisinau ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (135, N'Monaco ', N'Monaco ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (136, N'Mongolia ', N'Ulan Bator ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (137, N'Montenegro ', N'Podgorica ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (138, N'Montserrat (UK)', N'Brades, Plymouth', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (139, N'Morocco ', N'Rabat ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (140, N'Mozambique ', N'Maputo ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (141, N'Myanmar ', N'Naypyidaw ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (142, N'Namibia ', N'Windhoek ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (143, N'Nauru ', N'Yaren', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (144, N'Nepal ', N'Kathmandu ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (145, N'Netherlands ', N'Amsterdam ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (146, N'New Caledonia (France)', N'Nouméa ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (147, N'New Zealand ', N'Wellington ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (148, N'Nicaragua ', N'Managua ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (149, N'Niger ', N'Niamey ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (150, N'Nigeria ', N'Abuja ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (151, N'Niue (New Zealand)', N'Alofi ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (152, N'Norfolk Island (Australia)', N'Kingston ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (153, N'North Korea ', N'Pyongyang ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (154, N'Northern Mariana Islands (USA)', N'Saipan ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (155, N'Norway ', N'Oslo ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (156, N'Oman ', N'Muscat ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (157, N'Pakistan ', N'Islamabad ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (158, N'Palau ', N'Ngerulmud ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (159, N'Palestine ', N'Ramallah and Gaza', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (160, N'Panama ', N'Panama City ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (161, N'Papua New Guinea ', N'Port Moresby ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (162, N'Paraguay ', N'Asunción ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (163, N'Peru ', N'Lima ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (164, N'Philippines ', N'Manila ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (165, N'Pitcairn Islands (UK)', N'Adamstown ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (166, N'Poland ', N'Warsaw ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (167, N'Portugal ', N'Lisbon ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (168, N'Puerto Rico (USA)', N'San Juan ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (169, N'Qatar ', N'Doha ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (170, N'Republic of the Congo ', N'Brazzaville ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (171, N'Romania ', N'Bucharest ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (172, N'Russia ', N'Moscow ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (173, N'Rwanda ', N'Kigali ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (174, N'Saint Barthelemy', N'Gustavia, Saint Barthélemy', N'North America ')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (175, N'Saint Helena, Ascension, and Tristan da Cunha (UK)', N'Jamestown', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (176, N'Saint Kitts and Nevis ', N'Basseterre ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (177, N'Saint Lucia ', N'Castries ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (178, N'Saint Martin', N'Philipsburg', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (179, N'Saint Pierre and Miquelon (France)', N'Saint-Pierre', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (180, N'Saint Vincent and the Grenadines ', N'Kingstown ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (181, N'Samoa ', N'Apia ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (182, N'San Marino ', N'San Marino ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (183, N'São Tomé and Príncipe ', N'Sao Tome', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (184, N'Saudi Arabia ', N'Riyadh ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (185, N'Senegal ', N'Dakar ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (186, N'Serbia ', N'Belgrade ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (187, N'Seychelles ', N'Victoria ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (188, N'Sierra Leone ', N'Freetown ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (189, N'Singapore ', N'Singapore ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (190, N'Sint Maarten (Netherlands)', N'Philipsburg', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (191, N'Slovakia ', N'Bratislava ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (192, N'Slovenia ', N'Ljubljana ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (193, N'Solomon Islands ', N'Honiara ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (194, N'Somalia ', N'Mogadishu ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (195, N'South Africa ', N'Cape Town', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (196, N'South Korea ', N'Seoul ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (197, N'South Sudan ', N'Juba ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (198, N'Spain', N'Madrid ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (199, N'Sri Lanka ', N'Sri Jayawardenapura-kotte', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (200, N'Sudan ', N'Khartoum ', N'Africa')
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (201, N'Suriname ', N'Paramaribo ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (202, N'Swaziland ', N'Mata-utu ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (203, N'Sweden ', N'Stockholm ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (204, N'Switzerland ', N'Bern ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (205, N'Syria ', N'Damascus ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (206, N'Taiwan ', N'Taipei ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (207, N'Tajikistan ', N'Dushanbe ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (208, N'Tanzania ', N'Dodoma', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (209, N'Thailand ', N'Bangkok ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (210, N'Togo ', N'Lomé ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (211, N'Tokelau (New Zealand)', N'Nukunonu, Atafu,Tokelau', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (212, N'Tonga ', N'Nukuʻalofa ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (213, N'Transnistria ', N'Tiraspol ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (214, N'Trinidad and Tobago ', N'Port Of Spain ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (215, N'Tunisia ', N'Tunis ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (216, N'Turkey ', N'Ankara ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (217, N'Turkmenistan ', N'Ashgabat ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (218, N'Turks and Caicos Islands (UK)', N'Cockburn Town ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (219, N'Tuvalu ', N'Funafuti ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (220, N'Uganda ', N'Kampala ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (221, N'Ukraine ', N'Kiev ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (222, N'United Arab Emirates ', N'Abu Dhabi ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (223, N'United Kingdom ', N'London ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (224, N'United States ', N'Washington D.C. ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (225, N'United States Virgin Islands (USA)', N'Charlotte Amalie ', N'North America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (226, N'Uruguay ', N'Montevideo ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (227, N'Uzbekistan ', N'Tashkent ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (228, N'Vanuatu ', N'Port Vila ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (229, N'Vatican City ', N'Vatican City ', N'Europe')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (230, N'Venezuela ', N'Caracas ', N'South America')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (231, N'Vietnam ', N'Hanoi ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (232, N'Wallis and Futuna (France)', N'Mata-Utu ', N'Oceania')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (233, N'Western Sahara', N'El Aaiun', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (234, N'Yemen ', N'Sana''a ', N'Asia')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (235, N'Zambia ', N'Lusaka ', N'Africa')
INSERT [dbo].[Country] ([CountryId], [CountryName], [CapitalName], [Continent]) VALUES (236, N'Zimbabwe ', N'Harare ', N'Africa')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (1, N'Programmers, software development and IT professionals')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (2, N'Web design & development professionals')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (3, N'Accountants')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (4, N'Solicitors, lawyers')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (5, N'Economists')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (6, N'Business & financial project managers')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (7, N'Journalists, newspaper editors')
INSERT [dbo].[Occupation] ([OccupationId], [OccupationName]) VALUES (8, N'Engineering professionals')
SET IDENTITY_INSERT [dbo].[Questionnaire] ON 

INSERT [dbo].[Questionnaire] ([ParticipantId], [Title], [FirstName], [LastName], [DateOfBirth], [CountryId], [HouseAddress], [WorkAddress], [OccupationId], [JobTitle], [BusinessType], [AdditionalQuestionId]) VALUES (1, N'Mr', N'Sumate', N'Chimyindee', CAST(N'2019-12-09' AS Date), 209, N'Test', N'Test', 4, N'Test', N'Test', 1)
SET IDENTITY_INSERT [dbo].[Questionnaire] OFF
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[27] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AdditionalQuestion"
            Begin Extent = 
               Top = 128
               Left = 760
               Bottom = 301
               Right = 962
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AdditionalQuestionMapping"
            Begin Extent = 
               Top = 51
               Left = 296
               Bottom = 147
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2865
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AdditionalQuestionMapping_vw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AdditionalQuestionMapping_vw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[31] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Questionnaire"
            Begin Extent = 
               Top = 1
               Left = 426
               Bottom = 337
               Right = 637
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Occupation"
            Begin Extent = 
               Top = 36
               Left = 206
               Bottom = 132
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Country"
            Begin Extent = 
               Top = 68
               Left = 810
               Bottom = 164
               Right = 980
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4200
         Alias = 1110
         Table = 3435
         Output = 2295
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Questionnaire_vw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Questionnaire_vw'
GO
