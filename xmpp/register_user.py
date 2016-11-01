import requests
from requests.auth import HTTPBasicAuth

def register_user(host, virtual_host, user_data):
    url = "http://%s:5280/admin/server/%s/users/" % (host, virtual_host)
    auth = HTTPBasicAuth("admin@localhost", "password") # login with admin user
    resp = requests.post(url, data=user_data, auth=auth)
    print(resp)
    assert resp.status_code == 200

if __name__ == '__main__':
    host = "54.145.200.149"
    virtual_host = "54.145.200.149"
    test1 = { 'newusername': "test1", 'newuserpassword': "test", 'addnewuser': "Add User" }
    register_user(host, virtual_host, test1)
    test2 = { 'newusername': "test2", 'newuserpassword': "test", 'addnewuser': "Add User" }
    register_user(host, virtual_host, test2)
    test3 = { 'newusername': "test3", 'newuserpassword': "test", 'addnewuser': "Add User" }
    register_user(host, virtual_host, test3)
