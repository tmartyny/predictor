Refactor possibilities:
-Specify exact routes instead of just using resources.
-Store the @@aggregate variable in redis for quick access
-I know there's a better way than cookies to get the guess variable to carry over to the update controller. Don't want to use class instance variable. It shouldn't be a constant. I could store it as a field in the database for the user, but it's only needed to carry between the two controllers, so it doesn't need to be in the database.
-Wasn't sure if css/layout was a factor in the challenge. It didn't appear to be from the description so I focused on the other aspects. 
-Update controller is busy