# GitHubIssuesApi
A sample iOS application to display the Number of total issues in github repo

[Hosted Link !! Click Here](https://appetize.io/app/3jdtwcgwyj6vvhda7532v4m6mm?device=iphone5s&scale=100&orientation=portrait&osVersion=9.2)

**Solution Explaination**

This is a multi-threaded application where the threads are designed to fetch the count of open issues from the github api
Thread 1: Gets the total issues from the provided correct Url.
Thread 2: Gets the total issues opened in the last 24 hours.
Thread 3: Gets the total issues opened before 24 hours but within 7 days.
The Total number of issues opened more than 7 days ago are calculated from the following calculation
```
Total issues opened 7 days ago = Total open issues - total issues opened in 24 hours - total issues in the last 7 days

```
**Future Improvement**

Can provide the complete issues statistic for a user or an organisation and also provide a time based chart ploting the issues opened and closed in project. Along with the list of contributors and filters to it.
