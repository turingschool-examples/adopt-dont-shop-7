# Adopt, don't Shop

This is a paired project used in Turing School's Backend Program Module 2.

## Learning Goals

In this project, students will build upon the code in this repo to create a Pet Adoption Platform. Users will be able to apply to adopt pets, and Admins will be able to approve or reject applications and see statistics for the Shelters, Pets, and Applications in the system.

- Build out CRUD functionality for a many to many relationship
- Use ActiveRecord to write queries that join multiple tables of data together
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Validate models and handle sad paths for invalid data input
- Use flash messages to give feedback to the user
- Use partials in views
- Use `within` blocks in tests
- Track user stories using GitHub Projects
- Deploy your application to the internet

## Requirements

- Project must use Rails 7.0.x, Ruby 3.2.2, and PostgreSQL
- Use of `resources` on this project is not permitted
- Use of scaffolding on this project is not permitted
- Students wanting to use any extra gems on this project must first get permission from your instructors
    - Pre-approved gems are `pry, simplecov, capybara, rspec-rails, shoulda-matchers, faker, factory_bot_rails, orderly, launchy`

## Project Phases

1. [Set Up](./doc/set_up.md)
1. [User Stories](./doc/user_stories.md)
1. [Evaluation](./doc/evaluation.md)

## Check In

This project will have one Check In. During your Check In, you should be prepared to review your database schema for the many to many relationship, your deployment to the internet, and your GitHub Projects board.

## Project Documents
[Database schema](https://erd.dbdesigner.net/designer/schema/1693514690-adopt_dont_shop)
[DTR](https://docs.google.com/document/d/1bt8hrE2qSD9FLLe56inBho_DDstlvSUaVyQm2IfL5bc/edit)

---
# Description:
This project is a brownfield project, meaning that it was not created from scratch but was inherited by us and we built on top of a legacy code base. When we recieved the repo we were able to deploy(see Additional Documentation below for deployment link) with working functionality of the Pets, Shelters, Vetrinarians, and Veterinary Offices sections of the site. We were tasked with creating a Pet Adoption Platform for this existing site. We wanted Users to be able to apply to adopt pets, and Admins would be able to approve or reject applications, as well as see statistics for the Shelters, Pets, and Applications.



## Database Design: 

![db_design](https://user-images.githubusercontent.com/132625822/266146427-9b87629f-f2a2-4b9f-a6eb-9f104673c48d.png)
**Database Visual**


The Database has a many to many relationship in how the tables interrelate. So Shelters can have many pets, pets can belong to many applications, but only through the pet applications table.

## Contributers:

- Cory Powell - [Github](https://github.com/coryrpow) || [LinkedIn](https://www.linkedin.com/in/coryrpow/)
- Antoine Aube - [Github](https://github.com/Antoine-Aube) || [LinkedIn](https://www.linkedin.com/in/antoineaube/)

## Tech Stack:
- rspec-rails
- ruby
- pry
- capybara
- shoulda-matchers
- simplecov
- orderly
- deployed on heroku

## Additional Documentation:
- [Github Projects](https://github.com/users/coryrpow/projects/1)
- [Deployment Site](https://mysterious-thicket-11192-d50cbdd4fc1c.herokuapp.com/)
- [Docs File](https://docs.google.com/document/d/1tBAVjzctp13628lGgBPPK9kKkh3TGYcKZkk8VSxIL34/edit?usp=sharing)
- [DTR](https://docs.google.com/document/d/1bt8hrE2qSD9FLLe56inBho_DDstlvSUaVyQm2IfL5bc/edit?usp=sharing)
  


