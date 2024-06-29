select *
from CovidDeaths

select *
from CovidVaccinations


-- Population, total cases, new cases and total deaths based on location and date

select location, date, population, total_cases, new_cases, total_deaths
from CovidDeaths


-- % of people dying due to covid

select location, date, round((total_deaths / total_cases) * 100,2) DeathPercentage
from CovidDeaths


-- % of population infected with covid

select location, date, population, total_cases, round((total_cases / population) * 100,2) PercentOfPopulationInfected
from CovidDeaths


-- Countries with Highest Infection Rate compared to Population

select location, population, MAX(total_cases) MaxCases, max(round((total_cases / population) * 100, 2)) PercentOfPopulationInfected
from CovidDeaths
group by location, population
order by PercentOfPopulationInfected desc


-- Countries with Highest Death Count per Population

select location, population, MAX(total_deaths) MaxDeaths, MAX(round((total_deaths / population) * 100,2)) PercentOfDeaths
from CovidDeaths
group by location, population
order by PercentOfDeaths desc


-- Showing contintents with the highest death count per population

select continent, population, MAX(total_deaths) MaxDeaths
from CovidDeaths
where continent is not null
group by continent, population
order by MaxDeaths desc


-- Overall total cases, total deaths, and their % of deaths based on continent, location

select sum(new_cases), SUM(new_deaths), ROUND(sum(new_deaths) / SUM(new_cases) * 100,2) TotalDeathPercentage
from covidDeaths
where continent is not null
order by TotalDeathPercentage 

-- Shows Percentage of Population that has recieved Covid Vaccine

select cd.location, cd.population, ROUND(sum(cast(new_vaccinations as float)) / cd.population * 100 ,2) TotalVaccinatedPeople
from CovidDeaths cd
join CovidVaccinations cv
on cd.location = cv.location
where cd.location is not null and cd.population is not null
group by cd.location, cd.population
order by TotalVaccinatedPeople desc

