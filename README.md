# 🦠 COVID-19 Data Analysis Using SQL

This repository contains an SQL-based project focused on analyzing global COVID-19 data. The project includes database setup, table creation, data ingestion from CSV files, and a series of analytical SQL queries to explore trends in cases, deaths, and vaccinations.

---

## 📁 Project Contents

- `covid_analysis.sql`  
  The main SQL script that performs:
  - Creation of `CovidDeaths` and `CovidVaccinations` tables
  - Import of data from CSV files
  - SQL queries for in-depth data analysis
  - Creation of views and summary tables

---

## 📊 Datasets Used

1. **CovidDeaths.csv**  
   Contains data on daily COVID-19 cases, deaths, population, and other demographic factors.

2. **CovidVaccinations.csv**  
   Contains data on testing, vaccination progress, and public health policies.

> 🔔 **Note:** The CSV files must be present locally and properly formatted. Ensure MySQL’s `local_infile` is enabled with the command:  
> `SET GLOBAL local_infile = 1;`

---

## 🛠️ Key Features

### 📦 Database & Table Creation
- `CREATE DATABASE project;`
- Two main tables:
  - `CovidDeaths`
  - `CovidVaccinations`

### 📥 Data Import
Using `LOAD DATA LOCAL INFILE` to import data into the MySQL tables.

### 📊 Data Analysis Queries
- Total Cases vs Total Deaths
- Total Cases vs Population
- Death rate percentages by country
- Countries with highest infection and death counts
- Continent-level summaries
- Rolling vaccination tracking
- Population vs Vaccination metrics

### 🔎 View and Table Creation
- `PercentPopulationVaccinated` table for storing cumulative vaccination data
- `PercentPopulationVaccinatedView` for simplified querying and visualization

---

## 📌 Sample Queries

```sql
-- Death Percentage in the United States
SELECT location, date, total_cases, new_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1, 2;

-- Countries with Highest Infection Rate
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,
       MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;
