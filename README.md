# GitHubIssuesApi
A sample iOS application to display the Number of total issues in github repo

[Hosted Link !! Click Here](https://appetize.io/app/3jdtwcgwyj6vvhda7532v4m6mm?device=iphone5s&scale=100&orientation=portrait&osVersion=9.2)

**Sample Api Links**

[Total Issues](https://api.github.com/repos/Shippable/support/issues?state=open&per_page=100)</br>
[Last 24 Hours](https://api.github.com/repos/Shippable/support/issues?state=open&per_page=100&since=2016-02-22T11:24:59+05:30)</br>
[Last 7 days ](https://api.github.com/repos/Shippable/support/issues?state=open&per_page=100&since=2016-02-16T11:25:26+05:30)</br>

**Solution Explaination**

This is a multi-threaded application where the threads are designed to fetch the count of open issues from the github api

Thread 1: Gets the total issues from the provided correct Url.</br>
Thread 2: Gets the total issues opened in the last 24 hours.</br>
Thread 3: Gets the total issues opened before 24 hours but within 7 days.

The Total number of issues opened more than 7 days ago are calculated from the following calculation
```
Total issues opened 7 days ago = Total open issues - total issues opened in 24 hours - total issues in the last 7 days

```
**Future Improvement**

Can provide the complete issues statistic for a user or an organisation and also provide a time based chart ploting the issues opened and closed in project. Along with the list of contributors and filters to it. Options to create and maintain Issues from Mobile Device.
