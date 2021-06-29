# Assignment specifications

1. Login screen:
   This will be the first screen. a. It will have 4 UI items:
   1. An image of game.tv logo
   2. Username text field: It should have validation of min 3 characters and max 10 with proper error message if the validation fails.
   3. Password field: It should have validation of min 3 characters and max 10 with proper error message if the validation fails.
   4. Submit button: It should be disabled if either validation fails.
   
   b. Other points:
   1. If a user has already logged in, they should be automatically logged in and sent to the home screen directly next time they open the app.
   2. You don't need to hit an api to login. Just hardcode a couple of valid username/password pairs and show an error message if the user enters invalid pair.
   3. Some UI points:
    1. Put colors everywhere yourself. Try to make it look good.
    2. All 4 items should be horizontally and vertically centered both, one below the other
 
2. Home screen: This will hold some information related to the logged in user, along with a few tournament cards.
3. API:
  * Hit an API to fetch the data for the User Details section i.e. the UI elements above “Recommended for you” section. You can use any mocking server of your choice to create the API yourself.
  * For the “Recommended for you” section, hit the following api:
  http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all
  This api supports pagination, where you specify how many results you wish to receive using the limit parameter (say 10), then fetch the subsequent 10 items by specifying a cursor param in the subsequent api hit. This cursor param is to be picked from the response of preceding api hit. For example:
  http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=CmMKGQoMcmVnX2VuZF9kYXRlEgkIgLTH_rqS7AISQmoOc35nYW1lLXR2LXByb2RyMAsSClRvdXJuYW1lbnQiIDIxMDQ5NzU3N2UwOTRmMTU4MWExMDUzODEwMDE3NWYyDBgAIAE=
  The relevant data points from the above are: name, cover_url, game_name. Please implement infinite scroll for the above api

## Getting Started

Test Users -
Username - 9876543210 password - password
Username - 9898989898 password - password
