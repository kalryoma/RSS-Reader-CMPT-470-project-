Introduction:
This project is for the course CMPT470.
This project is to provide a service that allow users to collect, read and manage blog (RSS document)

Until the Check point, we finished: 
1. the user login, sign up function and finished the corresponding front-end design
2. the function for the user to subscribe RSS feed and reading articles.

For the final release,
We finished:
1. User management
2. RSS subscription and deletion
3. Article reading(link jumping to the article)
4. Part of Social network sharing(share articles to Facebook, Google+, etc.)
5. Rating list of stored feed
6. Search of article

Due to time limitation, the following functions remains to be implemented:
1. Social part of our own website.
	a. users can add other users as friend and share their RSS feeds and article to their friends.
	b. users can public their feeds or articles to all the users in our website no matter they are friends or not
	(We have finished Model and Controller part of this, however View is not finished.)
2. Read articles in our own website. For most of the RSS feeds, we can only get urls of their articles but not the content. So we plan to implement HTML parser for those article urls. But since different urls have different format for their article, we can't parse every HTML by our own. We implemented a few but there are still plenty of urls with various types of HTML for the articles. In order to keep the consistency, we finally decide to drop this part for now.
(We have wrote some code to analysis particular website, however this doesn't work for all so we use link instead in final release.)
3. And for the test case, you can try these rss feeds:
    - http://www.theverge.com/rss/frontpage
    - http://www.thestar.com/feeds.articles.news.rss (There are images in the article summary list page)
    Just add these url to the "add" page.

Instruction

Homepage:
Click “Get starting” to jump to the login page, if you don’t have an account, you can register by clicking the “Sign-up” button on the right above.

Sign up:
Set the email and your password. And you will receive a confirmation email. By click the link in that email, you will jump to the login page and carry out the normal login operation.

Login:
Login with your email and password. If you email is not confirmed, your login will be refused. After login, you will jump to “List” page. In this page it will show all the feeds you collected. If it is your first login, this page will be empty.

Add feed:
Click the menu button on the right bottom corner.
From up to down, these buttons are:
1. Rating buttion: show the 10 hottest feeds up to now among all users. This rating is based on the click rate.
2. The second button: jump to the search page. In this page, by inputting your keyword, it will return all the articles (not Feed) whose title contain the keyword.
3. The list button: show all the feed you have collected. If you want to see the articles under a specific title, click it.
4. Add button: add a new feed in your collection by input a RSS url

Logout:
Click the logout button on the right above corner to logout.


Back-end Logic

The back-end is realized by Ruby on Rails and it could be mainly concluded into 5 parts, including one partly done and another in plan for having techinal problem.

                                                    (Analysis RSS source)     (Analysis HTML Document)
                                                             |                           |
    User Management ==== Subscription Management ==== Feed Management ========== Article Management (Using link to websites instead)
           |                                                 |
           |                                                 |
           |                         Post to social network  |
    Social Management (Partly Done) ==========================
    
Detail Explaination:

    a. User Management
    
        We used gem Devise to easily help develop user management part. Devise helps us construct the login, register, login checking and forget password function.
        
            - Register module sends an email to the user after the he signed up. He could only login and use our service after clicking the link inside the email we sent to him.
        
            - Login checking module makes sure the user can get access to our service only after he have logined. It's worth mention that Devise has an ip-checking mechanism which helps ensure the security.
        
            - We also provides the service to help the user get his password back if he forgets that.
        
    b. Subscription Management    
           
        Subsciprion Links the user and the feed. The user could subscribe, cancel subscription and see all feed they have subscribed in the home page.(CRD) The is also a rate list helps the users to find feeds.
        
            - Once the user try to subscribe a feed, he needs to input the url of that feed (usually an xml file or .rss file), then the backend will check if this feed's information is stored inside the database.
            If so, backend just links the user and feed. Else, the url of feed will first be handled by Feed Management and then backend links them up.
            
            - Cancel subscription simply deletes the relation between the user and the feed.
            
            - In the home page, our website displays all the feeds subscribed by the user, the user could choose one of them to see what's new in that feed.
            
            - Rate list shows ten most clicked feeds.
            
    c. Feed Management
    
        A feed source is usually a .xml file or .rss file. When the user input the url of a feed, this feed will be analyze by the system.
        We use a gem 'Feedjira' to analysis this url. Once a feed address is analyze, its related information (including name and source) will be stored into the server for further use.
        
        Besides from adding feed and saving feed, the feed also provide a function to gain the newest rss file, analysis and output the info (including title, author and summary) of each article.
        
        We don't provide delete and update function for it's unnecessary for the user.
        
    d. Article Management
    
        This part is underconstruction. The original plan of this part is posting articles with a fixed form in our website. This involves grabbing html content from different kinds of website.
        We have done grabbing code for a particular website "The Verge" using Nokogiri as HTML parser. However this doesn't solve the problem, we can't write particular code for every rss provider.
        Some machine learning method may solve this problem but we don't have time to develop that. So we decide to use link to website instead of showing the whole article in final release.
        
        It's worth mention that some famous rssreader like "feedly" can't analysis all articles from different sources.
        
    e. Social Management
    
        This part is partly finished.
        
        For now, we can post a message to network after we read a particular article.
        We planed to create a buildin social network including adding friends and sharing feeds, however the View part of this module isn't finished in time.