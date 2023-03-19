from flask import Flask, render_template, request, session, redirect   
import mysql.connector

app = Flask(__name__)
app.secret_key = 'dbms_project'


# Create MySQL database connection
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="dbms_project"
)

# Create a cursor to execute SQL queries
mycursor = mydb.cursor()

@app.route('/')
def home():
    if 'user_id' in session:
        return render_template('main.html')
    else:
        return redirect('/login')
    
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = mydb.cursor(dictionary=True)
        cursor.execute("SELECT * FROM user WHERE username = %s AND password = %s", (username, password))
        user = cursor.fetchone()
        cursor.fetchall() # consume any unread results
        cursor.close()
        if user:
            if 'user_id' in user:
                session['user_id'] = user['user_id']
                return redirect('/')
            else:
                return render_template('login.html', error='User id not found')
        else:
            return render_template('login.html', error='Invalid credentials')
    else:
        return render_template('login.html')


    
@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        # Get user data from form
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        phone_number = request.form['phone_number']

        # Check if user with email already exists
        mycursor.execute("SELECT * FROM user WHERE email=%s", (email,))
        user = mycursor.fetchone()
        if user:
            return "User with this email already exists!"

        # Save user data to database
        sql = "INSERT INTO user (username, email, password, phone_number) VALUES (%s, %s, %s, %s)"
        val = (username, email, password, phone_number)
        mycursor.execute(sql, val)
        mydb.commit()

        message = "User created successfully"
        return render_template('signup.html', message=message)

    return render_template('signup.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect('/login')


if __name__ == '__main__':
    app.run(debug=True)
