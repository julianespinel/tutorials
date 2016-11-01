# XMPP

This tutorial has two main parts:

## 1. ejabberd setup

1. How to install an ejabberd server?<br>
   `apt-get -y install ejabberd`
1. Add an admin user to ejabberd<br>
   `ejabberdctl register admin localhost password`
1. Give admin privileges<br>
   Depending on the ejabberd version you are using you should modify the file `/etc/ejabberd/ejabberd.cfg` or `/etc/ejabberd/ejabberd.yml`

   In the file `/etc/ejabberd/ejabberd.cfg` (change the IP address):
     ```
     %% Admin user
     {acl, admin, {user, "admin", "localhost"}}.

     %% Hostname
     {hosts, ["54.145.200.149"]}.
     ```
   In the file `/etc/ejabberd/ejabberd.yml` (change the IP address):
   ```
   hosts:
     - "54.145.200.149"

   admin:
     user:
         - "admin": "localhost"
   ```
   Save the file and restart the ejabberd service.
1. Log in into the ejabberd web admin (change the IP address)<br>
   `http://54.145.200.149:5280/admin`<br>
   username: `admin@localhost`<br>
   password: `password`<br>

Source: https://www.digitalocean.com/community/tutorials/how-to-install-ejabberd-xmpp-server-on-ubuntu

## 2. Programmatic ejabberd usage with Python

First download the repository and go to the xmpp folder:

1. `git pull git@github.com:julianespinel/tutorials.git`
1. `cd tutorials/xmpp`

Before running each of the following steps, please open each .py file and change the value of the `host` variable for the IP address where your ejabberd server is located.

Python scripts:

1. Register a new user to server (Create new user in ejabberd)<br>
   Run the script:<br> `python 01_register_user_to_server.py`<br>
   Check (change the IP address):<br> `http://54.145.200.149:5280/admin/server/54.145.200.149/users/`
1. Add item to roster (Add user to friends list)<br>
   Run the script:<br> `python 02_add_item_to_roster.py`<br>
   Check (change the IP address):<br>
   `http://54.145.200.149:5280/admin/server/54.145.200.149/user/test1/roster/`
1. Accept subscription request (Accept friend request)<br>
   Run the script:<br> `python 03_accept_friend_request.py`<br>
   Check (change the IP address):<br> `http://54.145.200.149:5280/admin/server/54.145.200.149/user/test1/queue/`
1. Send message from user A to user B<br>
   Run the script:<br> `python 04_send_massage_from_A_to_B.py`<br>
   Check (change the IP address):<br>
   `http://54.145.200.149:5280/admin/server/54.145.200.149/user/test2/queue/`
1. Receive message from user A to user B<br>
   Run the script:<br> `python 05_receive_message_from_A_to_B.py`<br>
   Check (change the IP address):<br>
   `http://54.145.200.149:5280/admin/server/54.145.200.149/user/test1/queue/`
1. Remove item from roster (Remove user from friends list)<br>
   Run the script:<br> `python 06_delete_item_from_roster.py`<br>
   Check (change the IP address):<br>
   `http://54.145.200.149:5280/admin/server/54.145.200.149/user/test1/roster/`
