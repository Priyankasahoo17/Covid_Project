create database project;
CREATE TABLE CovidDeaths (
    iso_code VARCHAR(10),
    continent VARCHAR(20),
    location VARCHAR(100),
    date DATE,

    total_cases FLOAT,
    new_cases FLOAT,
    new_cases_smoothed FLOAT,
    total_deaths FLOAT,
    new_deaths FLOAT,
    new_deaths_smoothed FLOAT,

    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,

    reproduction_rate FLOAT,
    icu_patients FLOAT,
    icu_patients_per_million FLOAT,
    hosp_patients FLOAT,
    hosp_patients_per_million FLOAT,

    weekly_icu_admissions FLOAT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions FLOAT,
    weekly_hosp_admissions_per_million FLOAT,

    new_tests FLOAT,
    total_tests FLOAT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed FLOAT,
    new_tests_smoothed_per_thousand FLOAT,

    positive_rate FLOAT,
    tests_per_case FLOAT,
    tests_units VARCHAR(50),

    total_vaccinations FLOAT,
    people_vaccinated FLOAT,
    people_fully_vaccinated FLOAT,
    new_vaccinations FLOAT,
    new_vaccinations_smoothed FLOAT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,

    stringency_index FLOAT,
    population BIGINT,
    population_density FLOAT,
    median_age FLOAT,
    aged_65_older FLOAT,
    aged_70_older FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    cardiovasc_death_rate FLOAT,
    diabetes_prevalence FLOAT,
    female_smokers FLOAT,
    male_smokers FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT
);


SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/sahoo/OneDrive/Desktop/CovidDeaths.csv'
INTO TABLE CovidDeaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
  iso_code, continent, location, @date,
  total_cases, new_cases, new_cases_smoothed, total_deaths, new_deaths, new_deaths_smoothed,
  total_cases_per_million, new_cases_per_million, new_cases_smoothed_per_million,
  total_deaths_per_million, new_deaths_per_million, new_deaths_smoothed_per_million,
  reproduction_rate, icu_patients, icu_patients_per_million, hosp_patients, hosp_patients_per_million,
  weekly_icu_admissions, weekly_icu_admissions_per_million, weekly_hosp_admissions, weekly_hosp_admissions_per_million,
  new_tests, total_tests, total_tests_per_thousand, new_tests_per_thousand, new_tests_smoothed, new_tests_smoothed_per_thousand,
  positive_rate, tests_per_case, tests_units,
  total_vaccinations, people_vaccinated, people_fully_vaccinated, new_vaccinations, new_vaccinations_smoothed,
  total_vaccinations_per_hundred, people_vaccinated_per_hundred, people_fully_vaccinated_per_hundred, new_vaccinations_smoothed_per_million,
  stringency_index, population, population_density, median_age, aged_65_older, aged_70_older,
  gdp_per_capita, extreme_poverty, cardiovasc_death_rate, diabetes_prevalence, female_smokers, male_smokers,
  handwashing_facilities, hospital_beds_per_thousand, life_expectancy, human_development_index
)
SET date = STR_TO_DATE(@date, '%d-%m-%Y');

CREATE TABLE CovidVaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(20),
    location VARCHAR(100),
    date DATE,

    new_tests FLOAT,
    total_tests FLOAT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed FLOAT,
    new_tests_smoothed_per_thousand FLOAT,
    
    positive_rate FLOAT,
    tests_per_case FLOAT,
    tests_units VARCHAR(50),

    total_vaccinations FLOAT,
    people_vaccinated FLOAT,
    people_fully_vaccinated FLOAT,
    new_vaccinations FLOAT,
    new_vaccinations_smoothed FLOAT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,

    stringency_index FLOAT,
    population_density FLOAT,
    median_age FLOAT,
    aged_65_older FLOAT,
    aged_70_older FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    cardiovasc_death_rate FLOAT,
    diabetes_prevalence FLOAT,
    female_smokers FLOAT,
    male_smokers FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT
);

LOAD DATA LOCAL INFILE 'C:/Users/sahoo/OneDrive/Desktop/CovidVaccinations.csv'
INTO TABLE CovidVaccinations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
  iso_code,
  continent,
  location,
  @date,
  new_tests,
  total_tests,
  total_tests_per_thousand,
  new_tests_per_thousand,
  new_tests_smoothed,
  new_tests_smoothed_per_thousand,
  positive_rate,
  tests_per_case,
  tests_units,
  total_vaccinations,
  people_vaccinated,
  people_fully_vaccinated,
  new_vaccinations,
  new_vaccinations_smoothed,
  total_vaccinations_per_hundred,
  people_vaccinated_per_hundred,
  people_fully_vaccinated_per_hundred,
  new_vaccinations_smoothed_per_million,
  stringency_index,
  population_density,
  median_age,
  aged_65_older,
  aged_70_older,
  gdp_per_capita,
  extreme_poverty,
  cardiovasc_death_rate,
  diabetes_prevalence,
  female_smokers,
  male_smokers,
  handwashing_facilities,
  hospital_beds_per_thousand,
  life_expectancy,
  human_development_index
)
SET date = STR_TO_DATE(@date, '%d-%m-%Y');


-- select * from covidvaccinations
-- order by 3,4;

-- select * from coviddeaths
-- order by 3,4;

select date,total_cases,new_cases,total_deaths,population
from coviddeaths
order by 1,2;

-- Looking at Total Cases Vs Total Deaths
select location, date, total_cases, new_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
where location like '%States%'
order by 1,2;

-- Looking at Total Cases Vs Population
-- Shows what percentage of population got Covid 

select location,date,total_cases,new_deaths, (total_deaths/population)*100 as PercentPopulationInfected
from coviddeaths
-- where location like '%states%'
order by 1,2;

-- Looking at Countries with Highest Infection Rate compared to Population 

select location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 
as PercentPopulationInfected
from coviddeaths
group by 1,2
order by PercentPopulationInfected desc;

-- Showing Countries with Highest Death Count per Population
select location, max(total_deaths) as HighestDeathCount
from coviddeaths
where continent is not null
group by location
order by HighestDeathCount desc;

-- Lets break things by continent
-- showing continent with highest death count per population
select continent, max(total_deaths) as TotalDeathCount
from coviddeaths
group by 1
order by 2 desc;

-- Global Numbers
-- 1.
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths/new_cases)*100 as DeathPercentage
from coviddeaths
-- where location like '%States%'
-- where continent is not null
-- group by 1
order by 2,3 desc
limit 1;

-- 2
select continent, sum(new_deaths) as TotalDeathCount
from coviddeaths
where continent is not null
and continent not in ('World', 'Europian Union', 'International')
group by continent
order by TotalDeathCount;

-- 3
select location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PerecentPopulationInfected
from coviddeaths
group by location,population
order by PerecentPopulationInfected desc;

-- 4
select location, population,date, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PerecentPopulationInfected
from coviddeaths
group by location,population,date
order by PerecentPopulationInfected desc;

-- Looking at total population vs Vaccination


SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM covidvaccinations vac JOIN coviddeaths dea ON vac.location = dea.location 
AND vac.date = dea.date
where dea.continent is not null
ORDER BY 
2,3;

WITH PopVsVac AS (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) OVER (
            PARTITION BY dea.location 
            ORDER BY dea.location, dea.date
        ) AS RollingPeopleVaccinated
    FROM 
        covidvaccinations vac 
        JOIN coviddeaths dea 
        ON vac.location = dea.location AND vac.date = dea.date
    WHERE 
        dea.continent IS NOT NULL
)

SELECT *, (RollingPeopleVaccinated/population)*100 FROM PopVsVac;


-- Step 1: Create the table with correct structure
-- Step 0: Drop the table if it already exists
DROP TABLE IF EXISTS PercentPopulationVaccinated;

-- Step 1: Create the table
CREATE TABLE PercentPopulationVaccinated (
    continent VARCHAR(20),
    location VARCHAR(100),
    date DATE,
    population BIGINT,
    RollingPeopleVaccinated BIGINT
);

-- Step 2: Insert the data
INSERT INTO PercentPopulationVaccinated (continent, location, date, population, RollingPeopleVaccinated)
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.location, dea.date
    ) AS RollingPeopleVaccinated
FROM 
    covidvaccinations vac 
    JOIN coviddeaths dea 
    ON vac.location = dea.location AND vac.date = dea.date
WHERE 
    dea.continent IS NOT NULL;

-- Step 3: Query the result
SELECT 
    *, 
    (RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM 
    PercentPopulationVaccinated;

-- CREATING VIEWS TO STORE DATA FOR LATER VISULISATION
CREATE VIEW PercentPopulationVaccinatedView AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.location, dea.date
    ) AS RollingPeopleVaccinated
FROM 
    covidvaccinations vac 
    JOIN coviddeaths dea 
    ON vac.location = dea.location AND vac.date = dea.date
WHERE 
    dea.continent IS NOT NULL;
    
SELECT * FROM project.percentpopulationvaccinatedview;
