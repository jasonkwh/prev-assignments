__author__ = 'Hanxiang Huang'

from bottle import Bottle, template, static_file, request, response, HTTPError
import interface
from database import COMP249Db
from users import check_login, session_user, delete_session, generate_session

application = Bottle()
COOKIE_NAME = 'sessionid'


@application.route('/')
def index():
    """Index of Psst site"""
    db = COMP249Db()
    username = session_user(db)
    loginString = ""
    private = "#private" # string that makes the post private
    content = ""
    http = ""
    list = interface.post_list(db, usernick=None, limit=50)

    # if user not logged in
    if not username:
        str = "<h2><b>Welcome to Psst.</b> Latest pssts:</h2>" # title
        # display input field for username and password if the user not logged in
        loginString = "<form id='loginform' method='POST' action ='/login'><input type='text' name='nick' placeholder='username' class='focus' onKeyPress='return submitenter(this,event)'><input type='password' name='password' placeholder='password' class='focus' onKeyPress='return submitenter(this,event)'></form>"
        str = str + "<table>"
        for item in list:
            content = interface.post_to_html(item[3])
            http = interface.post_to_html(content)

            # not display the posts with the '#private' tag
            if(bool(private.lower() in http.lower())==False):
                str = str + "<tr>"
                str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + item[
                    1] + "</i></br></br></td></tr>" # username and contents
                users(item[2]) # generate /users/username page by users() function
                mentions(item[2]) # generate /mentions/username page by mentions function

    # if user logged in
    if username:
        # display the input field for adding posts instead of the title
        str = "<form action='/post' id='postform' method='POST'><input type='postfield' name='post' placeholder='post pssts (you can add #private tag to make the psst privately)' class='focus' onKeyPress='return submitenter(this,event)'></form>"
        for item in list:
            if(username==item[2]): # if user logged in, display his/her avatar, name, previous posts, the post mention, and logout option
                loginString = "<form action= '/logout' id='logoutform' name='logoutform' method='POST' ><table><tr><td><img src='" + item[4] + "' width='85'></td><td><h3>Logged in as " + username + "</h3><p><a href='/users/" + username + "'>Posted pssts</a></p><p><a href='/mentions/" + username + "'>@me pssts</a></p><p><a href='javascript: document.logoutform.submit();'>Logout</a></p></td></tr></table></form>"
        str = str + "<table>"
        at_user = "@" + username
        for item in list:
            content = interface.post_to_html(item[3])
            http = interface.post_to_html(content)

            # this if situation is for private message feature
            if((bool(private.lower() in http.lower()) == False) | (bool(at_user.lower() in http.lower())) | (bool(private.lower() in http.lower()) & bool(username.lower() in item[2].lower()))):
                str = str + "<tr>"
                str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + item[
                        1] + "</i></br></br></td></tr>" # username and contents
                users(item[2]) # generate /users/username page by users() function
                mentions(item[2]) # generate /mentions/username page by mentions function
    str = str + "</table>"
    return template('base.tpl', base=str, validate='', login=loginString)


@application.post('/login')
def login():
    """Display this page if any invalid user identification"""
    db = COMP249Db()
    list = interface.post_list(db, usernick=None, limit=50)
    private = "#private" # string that makes the post private
    content = ""
    http = ""
    str = "<h2><b>Welcome to Psst.</b> Latest pssts:</h2>" # title
    str = str + "<table>"

    # display previous posts
    for item in list:
        content = interface.post_to_html(item[3])
        http = interface.post_to_html(content)

        # not display the posts with the '#private' tag
        if(bool(private.lower() in http.lower())==False): # only display the messages without '#private'
            str = str + "<tr>"
            str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
            str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + item[
                    1] + "</i></br></br></td></tr>" # username and contents
            users(item[2]) # generate /users/username page by users() function
            mentions(item[2]) # generate /mentions/username page by mentions function
    str = str + "</table>"

    # if there are something within the login field...
    if 'nick' in request.forms:
        username = request.forms['nick'] # get username from the 'nick' field
        password = request.forms['password'] # get password from the 'password' field
        str2 = "<p style='color:red'>Failed.</p>"
        loginString = "<form id='loginform' method='POST' action ='/login'><input type='text' name='nick' placeholder='username' class='focus' onKeyPress='return submitenter(this,event)'><input type='password' name='password' placeholder='password' class='focus' onKeyPress='return submitenter(this,event)'></form>"
        if not check_login(db, username, password):
            return template('base.tpl', base=str, validate=str2, login=loginString) # display 'Failed' if invaild user identification
        generate_session(db, username) # generate the user session
        response.set_header('Location', '/')
        response.status = 303
        return "Redirect to /" # redirect to /


@application.post('/logout')
def logout():
    """Logout"""
    db = COMP249Db()
    username = session_user(db) # retrieve user session information from the database
    if username:
        delete_session(db, username) # remove user session
        response.set_header('Location', '/')
        response.status = 303
        return "Redirect to /" # redirect to /

@application.post('/post')
def add_post():
    """Adding post"""
    db = COMP249Db()
    username = session_user(db) # retrieve user session information from the database
    if username:
        content = request.forms['post'] # get user inputs from the input form 'post'
        interface.post_add(db, username, content) # add post by post_add function of interface.py
        response.set_header('Location', '/')
        response.status = 303
        return "Redirect to /" # redirect to /

@application.post('/search')
def search():
    """Search feature, can search user name and / or contents"""
    db = COMP249Db()
    username = session_user(db) # retrieve user session information from the database
    private = "#private" # string that makes the post private
    loginString = ""
    content = ""
    http = ""
    if 'search' in request.forms:
        search = request.forms['search'] # get user inputs from the search field
        str = "<h2>Search results for '" + search + "':</h2>" # title
        list = interface.post_list(db, usernick=None, limit=50)
        if not username: # display the things below only if user not logged in
            # display input field for username and password if the user not logged in
            loginString = "<form id='loginform' method='POST' action ='/login'><input type='text' name='nick' placeholder='username' class='focus' onKeyPress='return submitenter(this,event)'><input type='password' name='password' placeholder='password' class='focus' onKeyPress='return submitenter(this,event)'></form>"
            str = str + "<table>"
            for item in list:
                content = interface.post_to_html(item[3])
                http = interface.post_to_html(content)

                # this if situation is for private message feature
                if ((bool(private.lower() in http.lower())==False) & ((bool(search.lower() in item[2].lower())) | (bool(search.lower() in http.lower())))):
                    str = str + "<tr>"
                    str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                    str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + \
                          item[1] + "</i></br></br></td></tr>" # username and contents
                    users(item[2]) # generate /users/username page by users() function
                    mentions(item[2]) # generate /mentions/username page by mentions() function
            str = str + "</table>"
        if username: # display the things below only if user logged in
            at_user = "@" + username
            for item in list:
                if(username==item[2]): # if user logged in, display his/her avatar, name, previous posts, the post mention, and logout option
                    loginString = "<form action= '/logout' id='logoutform' name='logoutform' method='POST' ><table><tr><td><img src='" + item[4] + "' width='85'></td><td><h3>Logged in as " + username + "</h3><p><a href='/users/" + username + "'>Posted pssts</a></p><p><a href='/mentions/" + username + "'>@me pssts</a></p><p><a href='javascript: document.logoutform.submit();'>Logout</a></p></td></tr></table></form>"
            str = str + "<table>"
            for item in list:
                content = interface.post_to_html(item[3])
                http = interface.post_to_html(content)

                # this if situation is for private message feature
                if (((bool(private.lower() in http.lower()) == False) | (bool(at_user.lower() in http.lower())) | (bool(private.lower() in http.lower()) & bool(username.lower() in item[2].lower()))) & ((bool(search.lower() in item[2].lower())) | (bool(search.lower() in http.lower())))):
                    str = str + "<tr>"
                    str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                    str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + \
                          item[1] + "</i></br></br></td></tr>" # username and contents
                    users(item[2]) # generate /users/username page by users() function
                    mentions(item[2]) # generate /mentions/username page by mentions() function
            str = str + "</table>"
        return template('base.tpl', base=str, validate='', login=loginString)


@application.route('/users/<username:path>')
def users(username):
    """Generate the webpage that displays the user posts"""
    db = COMP249Db()
    uname = session_user(db) # retrieve user session information from the database
    loginString = ""
    private = "#private" # string that makes the post private
    list = interface.post_list(db, usernick=username, limit=50)
    list2 = interface.post_list(db, usernick=None, limit=50)
    str = ""
    for item in list:
        str = "<h2><b>" + item[2] + "</b> posted pssts:</h2>" # title
    if not uname:
        # display input field for username and password if the user not logged in
        loginString = "<form id='loginform' method='POST' action ='/login'><input type='text' name='nick' placeholder='username' class='focus' onKeyPress='return submitenter(this,event)'><input type='password' name='password' placeholder='password' class='focus' onKeyPress='return submitenter(this,event)'></form>"
        str = str + "<table>"
        content = ""
        http = ""
        for item in list2:
            if (username == item[2]):
                content = interface.post_to_html(item[3])
                http = interface.post_to_html(content)

                # not display the posts with the #private tag
                if(bool(private.lower() in http.lower())==False):
                    str = str + "<tr>"
                    str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                    str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + \
                          item[1] + "</i></br></br></td></tr>" # username and contents
        str = str + "</table>"
    if uname:
        for item in list2:
            if(uname==item[2]): # if user logged in, display his/her avatar, name, previous posts, the post mention, and logout option
                loginString = "<form action= '/logout' id='logoutform' name='logoutform' method='POST' ><table><tr><td><img src='" + item[4] + "' width='85'></td><td><h3>Logged in as " + uname + "</h3><p><a href='/users/" + uname + "'>Posted pssts</a></p><p><a href='/mentions/" + uname + "'>@me pssts</a></p><p><a href='javascript: document.logoutform.submit();'>Logout</a></p></td></tr></table></form>"
        str = str + "<table>"
        content = ""
        http = ""
        for item in list2:
            if (username == item[2]): # display the post only if the username and the author is the same person
                content = interface.post_to_html(item[3])
                http = interface.post_to_html(content)
                str = str + "<tr>"
                str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + \
                      item[1] + "</i></br></br></td></tr>" # username and contents
        str = str + "</table>"
    return template('base.tpl', base=str, validate='', login=loginString)


@application.route('/mentions/<username:path>')
def mentions(username):
    """Generate the webpage that displays @users"""
    db = COMP249Db()
    uname = session_user(db) # retrieve user session information from the database
    private = "#private" # string that makes the post private
    loginString = ""
    content = ""
    http = ""
    list = interface.post_list_mentions(db, usernick=username, limit=50)
    list2 = interface.post_list(db, usernick=None, limit=50)
    str = ""
    str = "<h2>These pssts mentioned <b>" + username + "</b>:</h2>" # title
    if not uname:
        # display input field for username and password if the user not logged in
        loginString = "<form id='loginform' method='POST' action ='/login'><input type='text' name='nick' placeholder='username' class='focus' onKeyPress='return submitenter(this,event)'><input type='password' name='password' placeholder='password' class='focus' onKeyPress='return submitenter(this,event)'></form>"
        str = str + "<table>"
        for item in list:
            content = interface.post_to_html(item[3])
            http = interface.post_to_html(content)
            if(bool(private.lower() in http.lower())==False): # not display the posts with the #private tag
                str = str + "<tr>"
                str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + item[
                    1] + "</i></br></br></td></tr>" # username and contents
        str = str + "</table>"
    if uname:
        at_user = "@" + uname
        for item in list2:
            if(uname==item[2]): # if user logged in, display his/her avatar, name, previous posts, the post mention, and logout option
                loginString = "<form action= '/logout' id='logoutform' name='logoutform' method='POST' ><table><tr><td><img src='" + item[4] + "' width='85'></td><td><h3>Logged in as " + uname + "</h3><p><a href='/users/" + uname + "'>Posted pssts</a></p><p><a href='/mentions/" + uname + "'>@me pssts</a></p><p><a href='javascript: document.logoutform.submit();'>Logout</a></p></td></tr></table></form>"
        str = str + "<table>"
        for item in list:
            content = interface.post_to_html(item[3])
            http = interface.post_to_html(content)

            # this if situation is for private message feature
            if((bool(private.lower() in http.lower()) == False) | ((uname==item[2]) & (bool(private.lower() in http.lower()))) | ((bool(at_user.lower() in http.lower())) & (bool(private.lower() in http.lower())))):
                str = str + "<tr>"
                str = str + "<td valign='top'><img src='" + item[4] + "' width='45'></td>" # user avatar
                str = str + "<td valign='bottom'><a href='/users/" + item[2] + "'>@" + item[2] + ": </a>" + http + " - <i>posted on " + item[
                    1] + "</i></br></br></td></tr>" # username and contents
        str = str + "</table>"
    return template('base.tpl', base=str, validate='', login=loginString)


@application.route('/static/<filename:path>')
def static(filename):
    return static_file(filename=filename, root='static')


if __name__ == '__main__':
    application.run(host='localhost', port=8080, debug=True)