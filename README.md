FriendCircle
============

This is a project that was requested by a company as part of their
interview. None of this code is proprietary and is available for use
in any way you feel comfortable

Description
-----------

FriendCircle is a mini facebook clone. Users can begin by signing up 
with the site. Signups require a unique username and no password for 
ease of development. Later updates may update this functionality, but 
for now choose a unique username. An error will appear if the username 
you choose is unavailable.

After signup you have the option to add friends who are registered with 
the site. You may see friends of friends, but not friends of those 
waiting to be or whom are not your friend. Once a friend request is 
accepted by the friend you've sent the request to you are friends until 
either yourself or the friend removes the friendship

Users are allowed to remove themselves from the site completely at any 
time. By doing so all friendships with the removed user will also be 
removed.

Specifications
--------------

The following methodologies and technologies are used

* Ruby on Rails (v 3.2.11)
* Strict MVC
* sqlite3
* rspec-rails

Features / Enhancements
-----------------------

I would like to update the following pieces when time becomes available

* Ajax friend requests
* Update UI from boring bootstrap default
* Re-evaluate friendship relationship in User Model
