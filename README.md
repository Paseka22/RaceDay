# RaceDay

## Project Description

RaceDay is a web-based event management system designed for South African road running, walking and cycling events.

The system allows organisers to manage events, categories, enrolments and participant results. Participants can create accounts, browse events, enter events and track their race results and performance history.

## User Roles

### Organiser
- Create, edit and delete events
- Manage event categories
- View event enrolments
- Capture participant results
- View event information

### Participant
- Create an account and log in
- Browse available events
- Enter events and select a category
- View personal enrolments
- Track race results and performance history

## Part 1

Part 1 focuses on planning and database design for the RaceDay system.

Deliverables include:

- Entity Relationship Diagram (ERD)
- API Endpoint Plan
- SQL Database Script
- GitHub repository and CI/CD validation

## Repository Structure

- `API endpoint.pdf` – API Endpoint Plan
- `RACEDAY_DATABASE.sql` – SQL database script
- `Untitled Diagram.drawio` – ERD
- `README.md` – Project documentation
- `.github/workflows/part1-ci.yml` – GitHub Actions validation

## Database Setup

The database script is designed for Microsoft SQL Server.

To set up the database:

1. Open SQL Server Management Studio.
2. Connect to the local SQL Server Express instance.
3. Open `RACEDAY_DATABASE.sql`.
4. Execute the script.
5. The RaceDay database and its tables will be created.

## CI/CD

GitHub Actions is used to validate that the required Part 1 files are present in the repository.

A successful workflow run confirms that the required planning files have been committed correctly.

## Video Demonstration

The Part 1 video demonstration will explain the planning decisions, ERD, API Endpoint Plan, SQL database and GitHub Actions validation.
