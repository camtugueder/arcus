# README
# Arcus school challenge
 I'm submitting at this point fixes to the issues that I have found with the code as it is, as well as the necessary additions to make have a basic authorization system.
 I'm also providing a list of several possible improvements that could be made for such a project. The reason I have not implemented any of them is that within the timeframe allotted to me to complete the exercise, I've only had a few hours to dedicate to this challenge, which were spent in setting up the project, finding fixing and testing the included changes.
 The instructions given left me wondering how much time I was supposed to invest and to which degre I should actually implement these features.
 If concrete implementations for any of the features mentioned is needed, I could revisit the project, but it would need to be on a weekend or otherwise free time in my schedule. 


## Table of Contents
- [Fixes](#fixes)
- [Proposed improvements](#proposed-improvements)
---
## Fixes
- The project did not build as it was, as one of its dependencies had been pulled off the ruby gems repositories. Had to update the rails version to 5.2.5 to get it to build.
- The courses index endpoint was taking over three minutes to show all 1500 courses, the following fixes were applied:
  - Creating an index for the course_id column in the enrollments table made it much faster, but still taking a couple of seconds for 1500 courses.
  - Adding an enrollments_count cache column to the courses table to keep track of how many enrollments each course has made it take less than a second.
    - Alternatively, using the following query also brought down the times to about the same extent, without using an extra column and with less complexity:
      - @courses = Course.left_joins(:enrollments)
        .select('courses.*, COUNT(enrollments.id) AS enrollments_count')
        .group('courses.id')
        .order(:created_at)
    - In order to test which scales better, the amount of courses was multiplied by 10 in the database, and both approaches tested again:
      - The count cache column approach was consistently faster by 20% with that 15000 courses.
    - In a real world scenario, the choice would depend on how many courses we're actually expecting to have, and if we really need to get/show them all at once. I would suggest starting with the left_joins query as it's simpler and works fast enough for a reasonable number of courses, and then if needed the switch to the cache count column should be easy enough.
  - Plucking the user's courses before hand instead of querying for them in the jbuilder view was not as impactful but still helped in further reducing the timings.
  - Finally, pagination was added as an example of a pattern normally used in restful APIs to present such large amounts of data.
  - Potential improvements: A search function could be added by using ElasticSearch or similar. Showing all courses is probably not the most user friendly approach, most likely we will be using an autocomplete with search, or the provided pagination. If we did need to show all of them and the number grew very large, we could implement a caching strategy to store all courses and after we get them from the cache we can pluck the ones the user is enrolled to.
- The students index endpoint, for 100.000 students, takes around 7 seconds to show them. In this case there aren't improvements to the query itself, we could potentially add the improvements mentioned for courses here. I have added pagination too, which would be a good place to start. 
- Fixed authentication, making it possible to create a session by hitting the create session endpoint with an email and password, which generates a token that is stored in the Student and checked for every request. This is a basic authentication method relying on sessions. I would propose a stateless solution like a JWT token with devise-jwt and a deny list, and then a gem like pundit for Authorization and rolify for managing user roles.
- The students_controller's destroy action was creating a new Student instead of finding the one that is sent through params.
- The teachers/index.json.jbuilder file was using student to name a variable that should be named teacher:
  - json.array! @teachers do |student|
    json.name student.name
    end
- Created a function in application_controller to avoid repeating the same code in most actions which tried to save or update a resource and returned an 422 status if it couldn't. Also applied it to the destroy actions.
---
## Possible improvements
There are many possible additions that could be made to this project, some of which I've already mentioned:
- JWT token authentication
- User roles. It would depend on where the project wants to go, but probably we'd want to have Students, Teachers and Admins which are all Users with shared properties.
- Authorization. We'd probably want some actions to be available only to certain roles.
- Full text search for searching for courses and students.
- Tests with rspec and FactoryBot.
- Dockerization.
---
